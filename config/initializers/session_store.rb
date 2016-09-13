# Be sure to restart your server when you modify this file.
# Rails.application.config.session_store :cookie_store, key: '_aggregator::'
# Rails.application.config.session_store :redis_store,
#   servers: {
#     host: 'localhost',
#     port: 6379,
#     db: 0,
#     namespace: 'aggregator3::session'
#   },
#   expires_in: 90.minutes
# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails g active_record:session_migration")

Rails.application.config.session_store :active_record_store,
  expire_after: 1.days,
  key: '_aggregator::'

ActiveRecord::SessionStore::Session.serializer = :json
