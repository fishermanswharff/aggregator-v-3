class Topic < ActiveRecord::Base
  validates :name, presence: true
  has_many :feed_topics
  has_many :feeds, through: :feed_topics
  has_many :followers, as: :followable
  has_many :users, through: :followers
end
