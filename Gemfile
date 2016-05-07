source 'https://rubygems.org'
gem 'rails', '4.2.6'
# gem 'rails-api'
gem 'pg', '~> 0.15'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3'
gem 'coffee-rails', '~> 4.1'
gem 'haml-rails'
gem 'jquery-rails'
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
gem 'twitter'
gem 'linkedin'
gem 'instagram'

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
