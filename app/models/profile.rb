class Profile < ApplicationRecord
  belongs_to :user
  accepts_nested_attributes_for :user
  has_one_attached :image
end
