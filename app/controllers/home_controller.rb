class HomeController < ApplicationController
  def index
    render locals: {
      message: 'hello',
      current_user: current_user,
      topics: Topic.includes(:feeds).all,
    }
  end
end
