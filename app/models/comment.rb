class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable, dependent: :destroy
  validates :content, presence: true

  def comment
    @parent ||= Comment.find_by(id: commentable_id) if commentable_type == 'Comment'
  end

end
