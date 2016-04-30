class HomeController < ApplicationController
  def index
    @message = 'ENV['S3_BUCKET_NAME']'
  end
end
