class V1::PasswordsController < ApplicationController

    skip_before_action :require_login , only: [ :forgot , :recover ]

    # POST /v1/passwords/forgot
    def forgot        
        return render_failed(message: I18n.t("Email_can't_be_blank") , status: :not_found) unless email = params[:email]
        
        if @company = Company.find_by( email.include?("@") ? { email: email } : { username: email })
            @company.generate_password_token
            Resque.enqueue(SendRecoverPassword, @company.id)
            render_success message: I18n.t("check_your_email") 
        else render_failed message: I18n.t('no_user_with_this_email') , status: :not_found 
        end
    end

    # PUT /v1/passwords/recover
    def  recover
        if company = Company.find_by(password_reset_token: params[:token])
            if company.reset_password( params[:password] , params[:password_confirmation])
                Resque.enqueue(SendPasswordChanged, company.id)
                company.regenerate_token
                render_success message: I18n.t("password_changed_successfully") , data: company 
            else render_failed message: company.errors.full_messages , status: :unprocessable_entity
            end
        else render_failed message: I18n.t("Link_not_valid_or_expired") , status: 404 end
    end

    # PUT /v1/passwords
    def update
        if  current_company.authenticate(params[:old_password])
            current_company.reset_password(params[:password], params[:password_confirmation])
            render_success message: I18n.t("password_changed_successfully")
        else render_failed message: I18n.t("old_password_not_correct") , status: :unauthorized
        end
    end
  
end
