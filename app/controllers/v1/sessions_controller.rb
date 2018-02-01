class V1::SessionsController < ApplicationController

  skip_before_action :require_login , only: :create 

  def create
    if company = valid_login?(params[:email] , params[:password])
      company.regenerate_token
      render_success message: I18n.t("success_log_in"), data: company
    else
      render_failed message: I18n.t("invalid_email_or_password") , status: :unauthorized
    end
  end

  def destroy
    Company.logout(current_company)
    render_success message: I18n.t("logged_out") , data: "https://example.com/login"
  end


  private

  def valid_login?(login_info , password)
    company = Company.find_by!(
      login_info.include?("@") ? {email: login_info} : {username: login_info})
  
    return company if company && company.authenticate(password)
  end
end
