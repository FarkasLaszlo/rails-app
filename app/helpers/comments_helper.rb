module CommentsHelper
  def comments_of comment
    comment.comments.map do |comment|
      render(comment)
    end.join.html_safe
  end
end
