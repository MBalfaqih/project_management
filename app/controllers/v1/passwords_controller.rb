class V1::PasswordsController < ApplicationController
    before_action :require_login , except: [ :forgot , :recover ]

    def forgot
        if !email = params[:email]
            return render_failed message: 'Email not present' , status: :not_found
        end

        @company = Company.find_by(
            email.include?("@") ? { email: email } : { username: email } )

        if @company 
            @company.generate_password_token
            CompanyMailer.recover_password_email(@company , @company.password_reset_token).deliver_now
            render_success message: "Please check your e-mail and click the verification link we sent" 
        else
            render_failed message: 'Email address not found. Please check it and try again.' , status: :not_found
        end
    end


    def  recover
        token = params[:token]
        company = Company.find_by(password_reset_token: token)
        if company
            if company.reset_password( params[:password] , params[:password_confirmation])
                company.regenerate_token
                render_success message: "Your password changed successfully" , data: company 
            else
                render_failed message: company.errors.full_messages , status: :unprocessable_entity
            end
        else
            render_failed message: "Link not valid or expired. Try generating a new link" , status: 404
        end

    end


    def update

        if  current_company.authenticate(params[:old_password])
            if  current_company.reset_password(params[:password], params[:password_confirmation])
                CompanyMailer.password_change_alert(current_company).deliver_now
                render_success message: "Your password changed successfully"
            else
                render_failed message: current_company.errors.full_messages , status: :unprocessable_entity
            end
        else
            render_failed message: "Your old password is not correct", status: :unauthorized
        end
    end
  
end
