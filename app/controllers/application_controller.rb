class ApplicationController < ActionController::API
 
  before_action :set_locale , :require_login

  include Response
  include ExceptionHandler
  
  def require_login
    authenticate_token || render_failed(message: "access denied , You are NOT logged in yet" , status: 401 )
  end

  def current_company
    @current_company ||= authenticate_token
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end

  
  private
  
  def authenticate_token
    token = request.headers['Authorization']
    Company.find_by(token: token)
  end


end
