class Follower < ActiveRecord::Base
  ALLOWED_TYPES = %w(Feed User Topic)

  belongs_to :user
  belongs_to :followable, polymorphic: true

  validates_associated :user
  validates :followable_type,
    inclusion: {
      in: ALLOWED_TYPES
    }

  scope :user_followers, -> (user_id) { where(followable_id: user_id, followable_type: 'User') }
end
