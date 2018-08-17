class Blog < ApplicationRecord
  has_many :comments, dependent: :destroy
  validates :title, presence: true, length: { minimum: 5 }
  validates :content, presence: true
  validates :author, presence: true
  validates :publication_date, presence: true
  validates :category, presence: true
end
