require 'rss'
require 'open-uri'

class Feed < ActiveRecord::Base
  after_create :save_description #, :save_name

  has_many :feed_topics
  has_many :topics,
    through: :feed_topics
  has_many :followers,
    as: :followable
  has_many :users,
    through: :followers

  validates :url,
    presence: true
  validates :url,
    format: {
      with: /[(http(s)?):\/\/(www\.)?a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#\/\/\=]*)/,
      message: 'Must be a valid url.'
    }
  validate :valid_feed?

  scope :not_followed, -> (user) { all.includes(:users).select { |f| !f.users.include?(user) } }

  def fetch_feed
    Feedjira::Feed.fetch_and_parse url
  rescue Feedjira::NoParserAvailable => e
    # do something?
    Rails.logger.debug "#{e}"
  end

  def valid_feed?
    begin
      parsed_feed.valid?
    rescue => e
      errors.add(:url, e.message)
    end
  end

  private

  def parsed_feed
    RSS::Parser.parse(url)
  end

  def save_description
    parsed = fetch_feed
    if parsed
      self.description = parsed.description || ''
    end
    self.save
  end

  def save_name
    # parsed = fetch_feed
  end
end
