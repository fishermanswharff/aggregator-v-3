class Follower < ActiveRecord::Base
  ALLOWED_TYPES = ['Feed', 'User', 'Topic']

  belongs_to :user
  belongs_to :followable, polymorphic: true

  validates_associated :user
  validates :followable_type, inclusion: { in: ALLOWED_TYPES }
end
