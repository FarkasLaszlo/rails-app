module CommentsHelper

  def comment_author comment
    User.find_by(serial: comment.author)&.name || "User not found"
  end
end
