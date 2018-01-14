class Api::V1::SessionsController < ApplicationController

  before_action :require_login , except: :create 

  # def index
  #   @users = User.all
  #   render json: {users: @users} , status: :ok
  # end

  def create
    if user = User.valid_login?(params[:email] , params[:password])
      user.regenerate_token
      render json: {token: user.token} , status: :ok
    else
      render_unauthorized("Invalid login or password")
    end
  end


  def destroy
    logout
    head :ok
  end


  private

  def logout
    current_user.update_columns(token: nil)
  end
  
end
