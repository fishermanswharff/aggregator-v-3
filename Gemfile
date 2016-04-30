source 'https://rubygems.org'
gem 'rails', '4.2.6'
gem 'pg', '~> 0.15'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'bcrypt', '~> 3.1.7'
gem 'newrelic_rpm'
gem 'rack-cors'
gem 'active_model_serializers'
gem 'nokogiri'

group :development, :test do
  gem 'byebug'
  gem "rspec-rails", "~> 3.1"
  gem "pry-byebug"
  gem "pry-rails"
  gem "factory_girl_rails", "~> 4.0"
  gem "faker"
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
  gem "unicorn"
  gem "rails_12factor"
  gem "rails_stdout_logging"
  gem "rails_serve_static_assets"
end
