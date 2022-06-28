class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  has_one :profile, dependent: :destroy
  has_many :friendships, dependent: :destroy

  def requested_friend?(user)
    friendships.any? { |f| f.friend_id == user.id }
  end

  def self.notifications(user)
    Friendship.joins('INNER JOIN notifications ON notifications.friendship_id = friendships.id')
              .select { |f| f.friend_id = user.id }
  end
end
