# t.string :first_name
# t.string :last_name
# t.string :username, null: false
# t.integer :role, null: false, default: 1 # defaults to generic user account
# t.string :email, unique: true, null: false
# t.string :password_digest
# t.string :token

# t.string :reset_password_token
# t.datetime :reset_password_sent_at
# t.datetime :remember_created_at

# t.integer :sign_in_count, default: 0, null: false
# t.datetime :current_sign_in_at
# t.datetime :last_sign_in_at
# t.timestamps null:false

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

  has_many :authentications,
    class_name: 'UserAuthentication',
    dependent: :destroy
  has_many :authentication_providers,
    through: :authentications

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
end
