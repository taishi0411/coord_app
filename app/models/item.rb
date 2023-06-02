class Item < ApplicationRecord
  validates :image, presence: true
  validates :clean_index, presence: true
  validates :heat_index, presence: true
  validates :name, presence: true
  validates :genre_id, presence: true


  belongs_to :user
  belongs_to :genre

  has_one_attached :image 
end
