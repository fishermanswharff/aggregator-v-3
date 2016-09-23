# Be sure to restart your server when you modify this file.

# Configure sensitive parameters which will be filtered from the log file.
Rails.application.config.filter_parameters += [
  :password,
  :password_confirmation,
  :new_password,
  :new_password_confirmation,
  :provider,
  :oauth_token,
  :oauth_verifier,
  'user-token'
]
