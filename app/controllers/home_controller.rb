class HomeController < ApplicationController
  def index
    @message = 'hello world'
    @users = User.all
  end
end
