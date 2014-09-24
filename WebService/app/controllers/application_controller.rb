class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate!
  		unless logged?
  			render json: {success:false, errors: ['Debe estar loggeado']}, status: 401
  		end
  end

  def logged?
  		return true if current_user.present?
  end

  def current_user
  		@current_user ||= authenticate_with_http_token do |token, options|
  			context = Auth.find_by token: token
  			return context.user if context
  		end
  end

  helper_method :current_user, :logged?

end
