class User < ActiveRecord::Base
  before_validation :set_token
  has_secure_password

  enum role: { admin: 0, regular: 1 }

  validates :email, :username, presence: true
  validates :email, :username, uniqueness: true
  validates :password, :password_confirmation, presence: true, on: :create
  validates :email, format: {
    with: /(?:[\w\d\S]+)@(?:[\w\d\-\.]){1,253}[\.](?:[\w]{2,4})/,
    message: 'Sorry, something is wrong with your email address.'
  }

  private

  def set_token
    return if token.present?
    self.token = generate_token
  end

  def generate_token
    SecureRandom.uuid.gsub(/\-/,'')
  end
end
