require 'csv'

puts 'Truncating the database…'
ActiveRecord::Base.establish_connection
ActiveRecord::Base.connection.tables.each do |table|
  next if table == 'schema_migrations'
  puts "truncating table #{table}"
  ActiveRecord::Base.connection.execute("TRUNCATE #{table} CASCADE")
end
puts 'Done truncating the database tables…'
puts "\n\n"
puts 'seeding admin user…'

jason = User.find_or_create_by(username: 'jasonwharff')
jason.update(
  first_name: 'Jason',
  last_name: 'Wharff',
  role: 'admin',
  email: 'fishermanswharff@mac.com',
  password: 'secret',
  password_confirmation: 'secret',
)
puts "Seeded user: #{jason.username}\n"
puts "seeding dummy users…"
if Rails.env.development?
  99.times do |n|
    password = 'password'
    User.create!(
      username: "#{n+1}-#{Faker::Internet.user_name}",
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      role: 'regular',
      email: "#{n+1}-#{Faker::Internet.email}",
      password: password,
      password_confirmation: password
    )
  end
end
puts 'Seeding AuthenticationProviders…'
AuthenticationProvider.find_or_create_by!(name: 'twitter')
AuthenticationProvider.find_or_create_by!(name: 'instagram')
AuthenticationProvider.find_or_create_by!(name: 'linkedin')
AuthenticationProvider.find_or_create_by!(name: 'facebook')
puts "Done seeding auth providers: #{AuthenticationProvider.pluck(:name).join(', ')}"
puts "\nSeeding feeds…"

CSV.foreach('db/seed_data/feeds.csv', headers: true, col_sep: ',', skip_blanks: true) do |row|
  unless Feed.exists?(url: row.field('url'))
    feed = Feed.create(url: row.field('url'), name: row.field('name'))
    puts "seeded Feed with url: #{feed.url}"
  end
end

puts "Seeded #{Feed.count} feeds…"
puts 'Seeding topics…'

CSV.foreach('db/seed_data/topics.csv', headers: true, col_sep: ',', skip_blanks: true) do |row|
  t = Topic.find_or_create_by(name: row.field('name'))
  puts "seeded Topic with name: #{t.name}"
end

puts "Seeded #{Topic.count} topics"
puts 'adding some feeds to topics…'
puts 'All done.'
