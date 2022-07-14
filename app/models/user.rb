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

  # some helpers for notifications:

  # returns new posts left on user's profile page.
  def self.profile_posts(user)
    Post.joins(:notification).where(friend_id: user.id)
  end

  # returns comments which are new to a post
  def self.comments(user)
    Comment.joins(:notification, :post).where('posts.user_id = ?', user.id)
  end

  def self.friend_requests(user)
    Friendship.joins(:notification).where(friend_id: user.id)
  end

  def self.likes(user)
    likes_on_posts(user) + likes_on_comments(user)
  end

  def self.likes_on_posts(user)
    Like.joins(:notification, :post).where('posts.user_id = ?', user.id)
  end

  def self.likes_on_comments(user)
    Like.joins(:notification, :comment).where('comments.user_id = ?', user.id)
  end

  def active_friends
    friends.includes(:friends, :profile, :posts).select { |f| f.friends.include?(self) }
  end

  def pending_friends
    friends.includes(:friends, :profile).reject { |f| f.friends.include?(self) }
  end
end
