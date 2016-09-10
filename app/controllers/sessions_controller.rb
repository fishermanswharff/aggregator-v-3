class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(username: session_params[:username])
    if user && user = user.authenticate(session_params[:password])
      user.increment_sign_in_count
      user.set_current_sign_in
      session[:current_user_id] = user.token
      Rails.logger.info "————————————————————————— session[:current_user_id]: #{session[:current_user_id]} —————————————————————————"
      redirect_to root_path
    else
      flash[:alert] = 'Invalid email/password combination'
      redirect_to root_path
    end
  end

  def destroy
    user = User.find_by(token: session[:current_user_id])
    user.set_last_sign_in
    session[:current_user_id] = nil
    redirect_to root_path
  end

  private

  def session_params
    params.require(:session).permit(:username, :password)
  end
end
