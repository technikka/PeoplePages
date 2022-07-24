class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  validates :body, length: { in: 3..12_000 }
  has_one :notification, dependent: :destroy

  default_scope { order(updated_at: :desc) }

  after_create { create_notification unless friend_id.nil? }
  before_destroy { notification&.destroy }

  # Posts appropriate to be shown on a user's page
  def self.user_fitted(user)
    self.includes({ user: [profile: [image_attachment: [:blob]]] }, :likes).where(friend_id: user.id).or(where(user_id: user.id, friend_id: nil))
  end
end
