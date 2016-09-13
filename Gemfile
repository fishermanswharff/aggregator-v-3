source 'https://rubygems.org'
gem 'rails', '4.2.7.1'                                                # we're riding on Rails
gem 'rails-api', require: 'rails-api/action_controller/api'           # enable the api version of rails
gem 'pg', '~> 0.15'                                                   # postgresql adapter
gem 'sass-rails', '~> 5.0'                                            # sass compiles to css
gem 'uglifier', '>= 1.3'                                              # compresses js
gem 'haml-rails'                                                      # we use haml views
gem 'jquery-rails'                                                    # jquery for rails
gem 'turbolinks'
gem 'sdoc', '~> 0.4', group: :doc
gem 'bcrypt', '~> 3.1'
gem 'newrelic_rpm'
gem 'rack-cors'
gem 'rack-ssl-enforcer'
gem 'active_model_serializers'
gem 'redis-rails'
gem 'redis-rack-cache'
gem 'rack-cache'
gem 'nokogiri'
gem 'feedjira'
gem 'draper', '~> 2.0'
gem 'twitter'
gem 'linkedin'
gem 'instagram'
gem 'sidekiq'
gem 'aws-sdk'
gem 'activerecord-session_store', '~> 1.0'                            # a session store backed by an Active Record class

group :development, :test do
  gem 'byebug'
  gem "pry-byebug"
  gem "pry-rails"
  gem "faker"
end

group :test do
  gem "rspec-rails", "~> 3.1"
  gem "factory_girl_rails", "~> 4.0"
  gem 'database_cleaner'
  gem "codeclimate-test-reporter", require: nil
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  gem "capistrano", "~> 3.4"
  gem 'capistrano-rails'
  gem 'capistrano-rvm'
  gem 'spring'
end

group :production do
  gem "rails_12factor"
  gem "rails_stdout_logging"
  gem "rails_serve_static_assets"
end
