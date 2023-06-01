class Item < ApplicationRecord
  validates :image, presence: true

  belongs_to :user
  belongs_to :genre

  has_one_attached :image 
end
