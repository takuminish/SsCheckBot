class Shortstory < ApplicationRecord
  has_many :shortstory_tag
  has_many :tag, through: :shortstory_tag


  accepts_nested_attributes_for :shortstory_tag, allow_destroy: true
  
  validates :title, presence: true
  validates :url, presence: true, uniqueness: true
  validates :image, presence: true
end
