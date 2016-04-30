require 'OAuth'

class TwitterOauthStrategy
  attr_reader :token, :url

  def initialize(token, url)
    @token = token
    @url = url
  end

  def request_token
    OAuth::RequestToken.new('twitter', @token, url)
  end
end
