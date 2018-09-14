class Comment < ApplicationRecord
  #ASSOCIATIONS
  belongs_to :user
  belongs_to :post
  belongs_to :comment, optional: true
  has_many :comments, dependent: :destroy
  
  #VALIDATIONS
  validates :content, presence: true
  
  #SCOPES
  default_scope { order(created_at: :desc) }
  scope :top_level, -> { where(comment_id: nil) }
end
