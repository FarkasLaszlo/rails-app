class Category < ApplicationRecord
  has_and_belongs_to_many :posts
  validates :name, presence: true, length: { minimum: 3 }
end
