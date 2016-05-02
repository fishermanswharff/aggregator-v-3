class HomeController < ApplicationController
  def index
    render locals: {
      message: 'hello',
      current_user: current_user
    }
  end
end
