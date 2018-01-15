class V1::Company::PasswordsController < ApplicationController
    #before_action :require_login

    def forgot
        if !email = params[:email]
            return json_response( {error: 'Email not present'} , :unprocessable_entity )
        end

        company = ::Company.find_by(email: email.downcase)
        if company 
            company.generate_password_token
            # SEND EMAIL HERE
            json_response({ status: "OK" , password_reset_token: company.password_reset_token })
        else
            render json: {error: ['Email address not found. Please check and try again.']}, status: :not_found
        end
    end


    def  recover
        debugger
        token = params[:token]
        company = ::Company.find_by(password_reset_token: token)
        if company
            company.password = params[:password]
            if company.save!
                json_response( {status: "OK" , password: company.password} )
            else
                json_response({error: company.errors.full_messages} , status: :unprocessable_entity)
            end
            
        else 
            json_response( object: {error: "Link not valid or expired. Try generating a new link"} , status: 404)
        end

    end



    def update 

    end






    # def create #create new token
    # end
    # def update #Rest password updaate with check token
    # end
    # def change #password if copmpany login
    # end

end
