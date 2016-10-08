class User < ActiveRecord::Base
  has_secure_password
  enum role: { admin: 0, regular: 1 }

  before_validation :set_token

  has_many :authentications,
    class_name: 'UserAuthentication',
    dependent: :destroy
  has_many :authentication_providers,
    through: :authentications
  has_many :following,
    class_name: 'Follower'
  has_many :followed,
    through: :following,
    source: :followable,
    source_type: 'User'
  has_many :feeds,
    through: :following,
    source: :followable,
    source_type: 'Feed'
  has_many :topics,
    through: :following,
    source: :followable,
    source_type: 'Topic'

  validates :email, :username,
    presence: true
  validates :email, :username,
    uniqueness: true
  validates :password, :password_confirmation,
    presence: true,
    on: :create
  validates :email,
    format: {
      with: /(?:[\w\d\S]+)@(?:[\w\d\-\.]){1,253}[\.](?:[\w]{2,4})/,
      message: 'Sorry, something is wrong with your email address.'
    }

  def increment_sign_in_count
    self.sign_in_count += 1
    self.save!
  end

  def reset_password
    self.reset_password_token = generate_token
    self.save!
  end

  def update_reset_password_ts
    self.reset_password_sent_at = generate_timestamp
    self.save!
  end

  def set_current_sign_in
    self.current_sign_in_at = generate_timestamp
    self.save!
  end

  def set_last_sign_in
    self.last_sign_in_at = self.current_sign_in_at
    self.save!
  end

  def authenticated_with(provider)
    authentication_providers.pluck(:name).include?(provider)
  end

  def twitter_feed
    auth = get_auth('twitter')
    twitter = TwitterClient.new(auth.token, auth.params['oauth_token_secret'])
    Rails.cache.fetch([:user_tweets, auth.token], expires_in: 5.minutes) do
      twitter.tweets
    end
  end

  def user_followers
    Follower.user_followers(id)
  end

  def top_feeds
    feeds.map do |f|
      parsed = Feedjira::Feed.fetch_and_parse(f.url)
      parsed.entries.slice!(3, parsed.entries.length - 3)
      parsed
    end
  rescue Faraday::ConnectionFailed => e
    return []
  end

  def change_password(password:, password_confirmation:)
    valid = password == password_confirmation
    self.password = password if valid
    self.update_reset_password_ts
    self.save
    valid
  end

  private

  def udpate_remember_created_at
    self.remember_created_at = generate_timestamp
    self.save!
  end

  def generate_timestamp
    DateTime.now.utc
  end

  def set_token
    return if token.present?
    self.token = generate_token
  end

  def generate_token
    SecureRandom.uuid.gsub(/\-/,'')
  end

  def get_auth(provider)
    authentications.joins(user: :authentication_providers).where(authentication_providers: { name: provider }).first
  end
end
