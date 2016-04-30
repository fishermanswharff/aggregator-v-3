# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(
  first_name: 'Jason',
  last_name: 'Wharff',
  username: 'fishermanswharff',
  role: 'admin',
  email: 'fishermanswharff@mac.com',
  password: 'secret_sauce',
  password_confirmation: 'secret_sauce'
)
