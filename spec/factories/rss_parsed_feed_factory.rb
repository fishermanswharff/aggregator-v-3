require_relative '../support/rss_parsed_feed'

FactoryGirl.define do
  factory :rss_parsed_feed do
    initialize_with do
      RSS::Maker.make("atom") do |maker|
        maker.channel.author = "matz"
        maker.channel.updated = Time.now.to_s
        maker.channel.about = "#{Faker::Internet.url}/news.rss"
        maker.channel.title = "Example Feed"

        maker.items.new_item do |item|
          item.link = "http://www.ruby-lang.org/en/news/2010/12/25/ruby-1-9-2-p136-is-released/"
          item.title = "Ruby 1.9.2-p136 is released"
          item.updated = Time.now.to_s
        end
      end
    end
  end
end
