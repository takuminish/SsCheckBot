class Shortstory < ApplicationRecord
  has_many :tag, through: :shortstory_tag
  has_many :shortstory_tag
  
  validates :title, presence: true
  validates :url, presence: true, uniqueness: true
  
end
