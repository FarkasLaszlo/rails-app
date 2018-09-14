class Category < ApplicationRecord
  #ASSOCIATIONS
  has_and_belongs_to_many :posts
  
  #VALIDATIONS
  validates :name, presence: true, length: { minimum: 3 }
end
