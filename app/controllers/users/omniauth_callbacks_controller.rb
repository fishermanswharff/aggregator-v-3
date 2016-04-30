require 'twitter_oauth_strategy'

class Users::OmniauthCallbacksController < ApplicationController

  def passthru
    self.send(params[:provider])
  end

  def twitter
    token = TwitterOauthStrategy.new(ENV['TWITTER_ACCESS_TOKEN'], root_url).request_token
  end
end
