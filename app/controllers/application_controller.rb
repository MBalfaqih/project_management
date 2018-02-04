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

  
  def page
    @page ||= params[:page] || 1
  end

  def per_page
    @per_page ||= params[:per_page] || 5
  end

  def paginate(collection)
    {
      current_page:  collection.current_page,
      next_page:     collection.next_page,
      previous_page: collection.prev_page,
      total_pages:   collection.total_pages,
      per_page:      collection.limit_value,
      total_records: collection.total_count
    }
  end

end
