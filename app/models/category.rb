class Category < ApplicationRecord
  has_and_belongs_to_many :blogs
  validates :name, presence: true, length: { minimum: 3 }
end
