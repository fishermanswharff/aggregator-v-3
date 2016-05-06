require 'rss'
require 'open-uri'

class Feed < ActiveRecord::Base
  validates :url, presence: true
  validates :url, format: { with: /[(http(s)?):\/\/(www\.)?a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#\/\/\=]*)/, message: 'Must be a valid url.' }
  validate :valid_feed?

  after_create :save_description

  has_many :feed_topics
  has_many :topics,
    through: :feed_topics

  has_many :followers,
    as: :followable
  has_many :users,
    through: :followers

  def fetch_feed
    Feedjira::Feed.fetch_and_parse url
  end

  private

  def valid_feed?
    begin
      parsed_feed.valid?
    rescue => e
      errors.add(:url, e.message)
    end
  end

  def parsed_feed
    RSS::Parser.parse(url)
  end

  def save_description
    parsed = fetch_feed
    self.description = parsed.description
    self.save!
  end
end
