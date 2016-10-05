require_relative '../support/feedjira_parsed_feed'

FactoryGirl.define do
  factory :feedjira_parsed_feed do
    initialize_with do
      Feedjira::Feed.parse(File.read(File.join(Rails.root, 'spec', 'fixtures', 'nytimes_homepage.xml')))
    end
  end
end
