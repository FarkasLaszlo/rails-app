module CommentsHelper
  def comments_of comment
    comment.comments.map do |comment|
      render(comment) # TODO FL render comments (render partial: 'comment', collection: comments)
    end.join.html_safe
  end
end
