ActiveRecord::Base.establish_connection
ActiveRecord::Base.connection.tables.each do |table|
  next if table == 'schema_migrations'
  puts "truncating table #{table}"
  ActiveRecord::Base.connection.execute("TRUNCATE #{table} CASCADE")
end
puts "\n\n"
puts 'seeding admin user…'
jason = User.find_or_create_by(username: 'jasonwharff')
jason.update_attributes(
  first_name: 'Jason',
  last_name: 'Wharff',
  role: 'admin',
  email: 'fishermanswharff@mac.com',
  password: 'secret',
  password_confirmation: 'secret',
)
puts "Seeded user: #{jason.username}\n"
puts 'Seeding AuthenticationProviders…'
AuthenticationProvider.find_or_create_by!(name: 'twitter')
AuthenticationProvider.find_or_create_by!(name: 'instagram')
AuthenticationProvider.find_or_create_by!(name: 'linkedin')
AuthenticationProvider.find_or_create_by!(name: 'facebook')
