class ApplicationController < ActionController::API
 
  include Response

    def require_login
      authenticate_token || render_failed(message: "access denied , You are NOT logged in yet" , status: 401 )
    end
  
    def current_company
      @current_company ||= authenticate_token
    end


    private
    
    def authenticate_token
      token = request.headers['Authorization']
      Company.find_by(token: token)
    end

end
