class Topic < ActiveRecord::Base
  has_many :feed_topics
  has_many :feeds, through: :feed_topics
  has_many :followers, as: :followable

  validates :name, presence: true
  validates :name, uniqueness: true
end
