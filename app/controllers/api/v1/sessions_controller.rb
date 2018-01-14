class Api::V1::SessionsController < ApplicationController

  before_action :require_login , except: :create 


  def create
    if company = Company.valid_login?(params[:email] , params[:password])
      company.regenerate_token
      json_response({token: company.token})
    else
      json_response( error: "Invalid E-mail or password" , status: :unauthorized)
    end
  end


  def destroy
    logout
    json_response( {message: "logged out"} )
  end


  private

  def logout
    current_company.update_columns(token: nil)
  end
  
end
