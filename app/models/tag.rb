class Tag < ApplicationRecord
    has_many :shortstory_tag
  has_many :shortstory, through: :shortstory_tag
  accepts_nested_attributes_for :shortstory_tag
  
  validates :name, presence: true, uniqueness: true
end
