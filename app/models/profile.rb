class Profile < ApplicationRecord
  belongs_to :user
  accepts_nested_attributes_for :user
  has_one_attached :image
  validates :image, content_type: ['image/png', 'image/jpeg']

  def image_as_thumbnail
    image.variant(resize_to_limit: [40, 40]).processed
  end

  def image_as_small
    image.variant(resize_to_limit: [200, 200]).processed
  end
end
