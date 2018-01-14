class ApplicationController < ActionController::API

    def require_login
      authenticate_token || render_unauthorized("access denied")
    end
  
    def current_user
      @current_user ||= authenticate_token
    end
    
    def authenticate_token
      token = request.headers['Authorization']
      User.find_by(token: token)
    end

    def render_unauthorized(message)
      errors = { errors: { detail: message } }
      render json: errors, status: :unauthorized
    end

end
