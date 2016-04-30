class HomeController < ApplicationController
  def index
    Rails.logger.info "——————————————————————————————— S3_BUCKET_NAME: #{ENV['S3_BUCKET_NAME']} ———————————————————————————————"
    @message = 'hello world'
    @users = User.all
  end
end
