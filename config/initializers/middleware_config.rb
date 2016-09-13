Rails.application.config.middleware.use Rack::MethodOverride
Rails.application.config.middleware.use ActionDispatch::Cookies
Rails.application.config.middleware.use ActionDispatch::Flash
