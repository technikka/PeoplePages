class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  has_one :profile, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  before_destroy do
    posts_from_friends = Post.where(friend_id: id)
    posts_from_friends.destroy_all
  end

  def active_friends
    friends.includes(:friends, :profile, :posts).select { |f| f.friends.include?(self) }
  end

  def pending_friends
    friends.includes(:friends, :profile).reject { |f| f.friends.include?(self) }
  end

  # helpers for notifications:

  def self.profile_posts(user)
    Post.joins(:notification).includes(:notification).where(friend_id: user.id)
  end

  def self.comments(user)
    Comment.joins(:notification, :post).includes(:notification).where('posts.user_id = ?', user.id)
  end

  def self.friend_requests(user)
    Friendship.joins(:notification).where(friend_id: user.id)
  end

  def self.likes(user)
    likes_on_posts(user) + likes_on_comments(user)
  end

  def self.likes_on_posts(user)
    Like.joins(:notification, :post).includes(:notification).where('posts.user_id = ?', user.id)
  end

  def self.likes_on_comments(user)
    Like.joins(:notification, :comment).includes(:notification).where('comments.user_id = ?', user.id)
  end
end
