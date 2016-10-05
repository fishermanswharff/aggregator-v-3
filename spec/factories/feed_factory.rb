FactoryGirl.define do
  factory :feed do
    name Faker::Company.name
    url Faker::Internet.url('nytimes.com', 'HomePage.xml')
  end
end
