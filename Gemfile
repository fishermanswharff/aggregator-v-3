source 'https://rubygems.org'
gem 'rails', '~> 5.0.0', '>= 5.0.0.1' # We're riding on rails
gem 'pg', '~> 0.19' # postgresql adapter
gem 'sass-rails', '~> 5.0' # sass compiles to css
gem 'uglifier', '>= 1.3' # compresses js
gem 'haml-rails' # we use haml views
gem 'jquery-rails' # jquery for rails
gem 'turbolinks' # Turbolinks makes navigating your web application faster
gem 'bcrypt', '~> 3.1' # Safe Passwords
gem 'newrelic_rpm' # New Relic monitoring
gem 'rack-cors' # Cross Origin resource sharing
gem 'rack-ssl-enforcer' # A simple Rack middleware to enforce ssl connections
gem 'active_model_serializers', '~> 0.10' # Serialize your models into json
gem 'redis' # Redis in rails
gem 'redis-rails' # redis-rails provides a full set of stores (Cache, Session, HTTP Cache) for Ruby on Rails
gem 'rack-cache' # HTTP caching
gem 'nokogiri' # Parse/Read/Build XML/HTML
gem 'feedjira' # Parse and Read Rss & Atom Feeds
gem 'draper', '3.0.0.pre1' # Decorators
gem 'twitter' # Twitter Access
gem 'linkedin' # LinkedIn access
gem 'instagram' # Instagram access
gem 'sidekiq' # Background workers
gem 'aws-sdk' # Software Developer Kit for AWS
gem 'activerecord-session_store', '~> 1.0' # a session store backed by an Active Record class

group :development, :test do
  gem 'byebug' # debugging in ruby
  gem 'pry-byebug' # step by step debugging
  gem 'pry-rails' # initialize rails console with pry
  gem 'faker' # fake data
end

group :test do
  gem 'rspec-rails', '~> 3.1' # testing suite
  gem 'factory_girl_rails', '~> 4.0' # build your objects in test environments
  gem 'database_cleaner' # cleans up the database in test env
  gem 'codeclimate-test-reporter', require: nil # code linter/evaluator
  gem 'webmock' # stub out http requests
end

group :development do
  gem 'web-console', '~> 2.0' # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'capistrano', '~> 3.4' # framework for building automated deployment scripts
  gem 'capistrano-rails' # Rails specific tasks for Capistrano v3
  gem 'capistrano-rvm' # RVM support for Capistrano v3
  gem 'spring' # Rails application preloader
end

group :production do
  gem 'rails_12factor' # Makes running your Rails app easier
  gem 'rails_stdout_logging' # Rails gem to configure your app to log to standard out.ˇ
  gem 'rails_serve_static_assets' # Rails gem to enable serving of static assets
end
