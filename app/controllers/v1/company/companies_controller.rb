class V1::Company::CompaniesController < ApplicationController

    def index
        companies = ::Company.order(id: :ASC)
        json_response(companies)
    end

    def create
        @company = ::Company.new(company_params)
        if @company.save
            CompanyMailer.welcome_email(@company).deliver_now
            @company.regenerate_token
            json_response({ Message: "You successfully signed in" , token: @company.token })
        else
            json_response(Message: "Something went wrong! ,make sure that you enter the same password or you have unique username & email ")
        end
    end

    private 
    def company_params
        params.permit(:company_name , :username , :email , :password , :password_confirmation ) ### /LOGO
    end

end
