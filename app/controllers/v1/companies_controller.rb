class V1::CompaniesController < ApplicationController
    
    skip_before_action :require_login , only: :create

    # GET /v1/companies
    def show
        render_success(data: V1::CompanySerializer.new(current_company))
    end

    # POST /v1/companies
    def create
        company = Company.new(company_params)
        company.save!
        # CompanyMailer.welcome_email(company).deliver_later
        MailingJob.perform_later(company: company , mail_type: "welcome_email")
        company.regenerate_token
        render_success( message: I18n.t("signed_in"), data: V1::CompanySerializer.new(company))
    end

    # PUT /v1/companies
    def update
        current_company.update!(company_params)
        render_success message: I18n.t("profile_updated_successfully"),
                          data: V1::CompanySerializer.new(current_company)
    end
    

    private 
    def company_params
        params.permit(:company_name, :username, :email, :logo, :password, :password_confirmation )
    end

end
