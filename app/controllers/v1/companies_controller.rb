class V1::CompaniesController < ApplicationController
    
    skip_before_action :require_login , only: :create


    # GET /v1/companies
    def show
        render_success data: V1::CompanySerializer.new(current_company)
    end


    # POST /v1/companies
    def create
        company = Company.create!(company_params)
        Resque.enqueue(SendWelcome, company.id)
        render_success( message: I18n.t("signed_in"), data: V1::CompanySerializer.new(company))
    end


    # PUT /v1/companies
    def update
        render_success message: I18n.t("profile_updated_successfully"),
                       data:    V1::CompanySerializer.new(current_company) if current_company.update!(company_params)
    end
    
    

    private 
    def company_params
        params.permit(:company_name, :username, :email, :logo, :password, :password_confirmation )
    end

end
