class UserAuthentication < ActiveRecord::Base
  validates_associated :user
  validates_associated :authentication_provider

  belongs_to :user
  belongs_to :authentication_provider

  def self.create_from_omniauth(params, user, provider)
    auth_provider = AuthenticationProvider.find_by(name: provider)
    create!(
      user: user,
      authentication_provider: auth_provider,
      uid: params['user_id'],
      token: params['oauth_token'],
      token_expires_at: 1.week.from_now.to_datetime,
      params: params.to_json,
    )
  end
end
