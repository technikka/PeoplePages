class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  has_one :profile, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :notifications, dependent: :destroy

  def requested_friend?(user)
    friendships.any? { |f| f.friend_id == user.id }
  end
end
