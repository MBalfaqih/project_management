class V1::Company::SessionsController < ApplicationController

  before_action :require_login , except: :create 

  def create
    if company = ::Company.valid_login?(params[:email] , params[:password])
      company.regenerate_token
      render_success( message: "You logged in successfully"  , data: company.token)
    else
      render_failed( message: "Invalid E-mail or password" , status: :unauthorized)
    end
  end

  def destroy
    logout
    render_success( message: "logged out" , data: "https://example.com/login")
  end


  private

  def logout
    current_company.update_columns(token: nil)
  end
  
  def self.valid_login?(login_info , password)
  company = Company.find_by(
    login_info.include?("@") ? {email: login_info} : {username: login_info}
    )
    # company = Company.where(email: login_info).or(Company.where(username: login_info )).first
    if company && company.authenticate(password)
      company
    end
  end
end
