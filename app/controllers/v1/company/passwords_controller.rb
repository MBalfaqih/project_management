class V1::Company::PasswordsController < ApplicationController
    before_action :require_login , except: [ :forgot , :recover ]

    def forgot
        if !email = params[:email]
            return json_response( {error: 'Email not present'} , :unprocessable_entity )
        end

        @company = ::Company.where(email: email.downcase).or(::Company.where(username: email )).first
        if @company 
            @company.generate_password_token
            CompanyMailer.recover_password_email(@company , @company.password_reset_token).deliver_now
            json_response({ status: "Please check your e-mail and click the verification link we sent"  })#, password_reset_token: company.password_reset_token
        else
            render json: {error: ['Email address not found. Please check and try again.']}, status: :not_found
        end
    end


    def  recover
        token = params[:token]
        @company = ::Company.find_by(password_reset_token: token)
        if @company
            if @company.reset_password!(params[:password],params[:password_confirmation])
                json_response( {status: "OK" , password: @company.password} )
            else
                json_response( error: @company.errors.full_messages , status: :unprocessable_entity)
            end
        else 
            json_response( object: {error: "Link not valid or expired. Try generating a new link"} , status: 404)
        end

    end


    def update
        @current_comp = current_company
        if  @current_comp.authenticate(params[:old_password])
            if @current_comp.reset_password!(params[:password],params[:password_confirmation])
                CompanyMailer.password_change_alert(@current_comp).deliver_now
                json_response({status: "The password changed successfully" })
            else
                json_response(error: @current_comp.errors.full_messages , status: :unprocessable_entity)
            end
        else
            json_response(error: "The password is not correct", status: :unprocessable_entity)
        end
    end

end
