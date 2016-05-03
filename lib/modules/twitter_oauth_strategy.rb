class TwitterOauthStrategy
  def initialize
  end

  def request_token(token, url)
    OAuth::RequestToken.new('twitter', token, url)
  end

  def access_token(data)
    OAuth::AccessToken.new('twitter', data)
  end
end
