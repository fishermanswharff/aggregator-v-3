class AuthenticationProvider < ActiveRecord::Base
  validates :name, presence: true
  has_many :user_authentications
  has_many :users, through: :user_authentications
end
