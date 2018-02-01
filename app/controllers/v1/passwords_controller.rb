class V1::PasswordsController < ApplicationController

    skip_before_action :require_login , only: [ :forgot , :recover ]

    def forgot
        unless email = params[:email]
            return render_failed message: I18n.t("Email_can't_be_blank") , status: :not_found
        end

        @company = Company.find_by( email.include?("@") ? { email: email } : { username: email })
        if @company 
            @company.generate_password_token
            CompanyMailer.recover_password_email(@company , @company.password_reset_token).deliver_later
            render_success message: I18n.t("check_your_email") 
        else
            render_failed message: I18n.t('no_user_with_this_email') , status: :not_found
        end
    end


    def  recover
        token = params[:token]
        company = Company.find_by(password_reset_token: token)
        if company
            if company.reset_password( params[:password] , params[:password_confirmation])
                company.regenerate_token
                render_success message: I18n.t("password_changed_successfully") , data: company 
            else
                render_failed message: company.errors.full_messages , status: :unprocessable_entity
            end
        else
            render_failed message: I18n.t("Link_not_valid_or_expired") , status: 404
        end
    end


    def update
        if  current_company.authenticate(params[:old_password])
            current_company.password_required = true
            current_company.reset_password(params[:password], params[:password_confirmation])
            render_success message: I18n.t("password_changed_successfully")
        else
            render_failed message:  I18n.t("old_password_not_correct") , status: :unauthorized
        end
    end
  
end
