class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  has_one :profile, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  scope :notifications, ->(user) { }
  # friendship.notification
  # notification.friendship
  # friendship's friend_id is whose notification this is

  def requested_friend?(user)
    friendships.any? { |f| f.friend_id == user.id }
  end

  # ATTENTION: MOVE TO SCOPE
  # def self.friends(user)
    
  # end


  # ATTENTION: MOVE TO SCOPE
  # def self.notifications(user)
  #   # Find friendships of friend id which have corresponding notification
  #   Friendship.joins('INNER JOIN notifications ON notifications.friendship_id = friendships.id INNER JOIN users ON users.id = friendship.friend_id').where('friendship.friend_id = user.id')
  # end
end
