module ApplicationHelper

  def current_user
    @_current_user ||= session[:current_user_id] && User.find_by(token: session[:current_user_id])
  end
end
