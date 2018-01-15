class V1::Company::CompaniesController < ApplicationController

    def index
        companies = ::Company.all
        json_response(companies)
    end

    def create
        company = ::Company.new(company_params)
        if company.save
            company.regenerate_token
            json_response({ Message: "You successfully signed in" , token: company.token })
        else
            json_response(Message: "Something went wrong! , make sure that you have unique username & email ")
        end
    end



    private 
    def company_params
        params.permit(:company_name , :username , :email , :password ) ### /LOGO
    end

end
