class V1::Company::CompaniesController < ApplicationController

    def index
        companies = ::Company.order(id: :ASC)
        render_success(data: companies)
    end

    def create
        @company = ::Company.new(company_params)
        if @company.save
            CompanyMailer.welcome_email(@company).deliver_now
            @company.regenerate_token
            render_success( message: "You successfully signed in" , data: @company )
        else
            render_failed( data: @company.errors.full_messages )
        end
    end

    private 
    def company_params
        params.permit(:company_name, :username, :email, :logo, :password, :password_confirmation )
    end

end
