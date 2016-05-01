class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout 'aggregator'

  def current_user
    @_current_user ||= session[:current_user_id] && User.find_by(token: session[:current_user_id])
  end

  protected

  def is_admin?
    unless current_user.admin?
      self.headers['WWW-Authenticate'] = 'Token realm="Application"'
      render json: {
        error: 'You are not an admin'
      }, status: 403
    end
  end
end
