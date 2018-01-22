class V1::CompaniesController < ApplicationController
    
    before_action :require_login , except: [:create , :index]


    def show
        render_success(data: current_company)
    end


    def create
        company = Company.new(company_params)
        if company.save
            CompanyMailer.welcome_email(@company).deliver_now
            company.regenerate_token
            render_success( message: "You successfully signed in" , data: company )
        else
            render_failed( data: company.errors.full_messages )
        end
    end


    def update
        if current_company.update!(company_params)
            render_success message: "your profile updated successfully" ,data: current_company
        else
            render_failed message: current_company.errors.full_messages ,status: :unprocessable_entity
        end
    end
    

    private 
    def company_params
        params.permit(:company_name, :username, :email, :logo, :password, :password_confirmation )
    end

end
