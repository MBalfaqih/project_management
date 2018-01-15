class V1::Company::SessionsController < ApplicationController

  before_action :require_login , except: :create 


  def create
    if company = ::Company.valid_login?(params[:email] , params[:password])
      company.regenerate_token
      json_response({ Message: "You successfully logged in"  , token: company.token })
    else
      json_response( error: "Invalid E-mail or password" , status: :unauthorized)
    end
  end


  def destroy
    logout
    json_response( { message: "logged out" } )
  end


  private

  def logout
    current_company.update_columns(token: nil)
  end
  
end
