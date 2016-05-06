class FeedTopic < ActiveRecord::Base
  belongs_to :feed
  belongs_to :topic

  validates_associated :feed
  validates_associated :topic
end
