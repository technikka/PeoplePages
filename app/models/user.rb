class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  has_one :profile, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  before_destroy do
    posts_from_friends = Post.where(friend_id: id)
    posts_from_friends.destroy_all
  end

  def self.notifications(user)
    Friendship.joins(:notification).where(friend_id: user.id)
  end

  def active_friends
    friends.includes(:friends, :profile, :posts).select { |f| f.friends.include?(self) }
  end

  def pending_friends
    friends.includes(:friends, :profile).reject { |f| f.friends.include?(self) }
  end
end
