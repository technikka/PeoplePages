class Profile < ApplicationRecord
  belongs_to :user
  accepts_nested_attributes_for :user
  has_one_attached :image

  def image_as_thumbnail
    return unless image.content_type.in?(%w[image/jpeg image/png])

    image.variant(resize_to_limit: [200, 200]).processed
  end
end
