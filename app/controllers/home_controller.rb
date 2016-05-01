class HomeController < ApplicationController
  def index
    render locals: {
      message: 'hello',
      current_user: current_user
    }
    Rails.logger.info "——————————————————— #{session[:current_user_id]} ———————————————————"
  end
end
