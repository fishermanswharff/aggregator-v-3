class TwitterClient

  attr_reader :client, :token

  def initialize(token, secret)
    @token = token
    @client = get_client(token: token, secret: secret)
  end

  def tweets
    client.home_timeline
  end

  def get_client(token: token, secret: secret)
    Twitter::REST::Client.new do |config|
      config.consumer_key = ENV["TWITTER_CONSUMER_KEY"]
      config.consumer_secret = ENV["TWITTER_CONSUMER_SECRET"]
      config.access_token = token
      config.access_token_secret = secret
    end
  end
end
