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
jason.update_attributes(
  first_name: 'Jason',
  last_name: 'Wharff',
  role: 'admin',
  email: 'fishermanswharff@mac.com',
  password: 'secret',
  password_confirmation: 'secret',
)

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

puts "Seeded user: #{jason.username}\n"
puts 'Seeding AuthenticationProviders…'

AuthenticationProvider.find_or_create_by!(name: 'twitter')
AuthenticationProvider.find_or_create_by!(name: 'instagram')
AuthenticationProvider.find_or_create_by!(name: 'linkedin')
AuthenticationProvider.find_or_create_by!(name: 'facebook')

puts "Done seeding auth providers: #{AuthenticationProvider.pluck(:name).join(', ')}"
puts "\nSeeding feeds…"
cnn = Feed.find_or_create_by(url: 'http://rss.cnn.com/rss/cnn_topstories.rss', name: 'CNN')
atom = Feed.find_or_create_by(url: 'http://blog.atom.io/feed.xml', name: 'Atom by Github')
wash_post_politics = Feed.find_or_create_by(url: 'http://feeds.washingtonpost.com/rss/politics', name: 'Washington Post Politics')
mash = Feed.find_or_create_by(url: 'http://feeds.mashable.com/Mashable', name: 'Mashable')
puts "Seeded #{Feed.count} feeds…"
puts 'Seeding topics…'
politics = Topic.find_or_create_by(name: 'Politics')
tech = Topic.find_or_create_by(name: 'Tech')
news = Topic.find_or_create_by(name: 'News')
puts "Seeded #{Topic.count} topics"
puts 'adding some feeds to topics…'
cnn.topics << news
atom.topics << tech
wash_post_politics.topics << politics
mash.topics << tech
puts 'All done.'
