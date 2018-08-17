class Comment < ApplicationRecord
  belongs_to :blog
  validates :content, presence: true
  validates :author, presence: true
  validates :date, presence: true
end
