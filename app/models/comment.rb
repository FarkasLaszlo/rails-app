class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  belongs_to :comment, optional: true
  has_many :comments, dependent: :destroy
  # TODO FL logikai egységek körül hagyj szünetet
  validates :content, presence: true
end
