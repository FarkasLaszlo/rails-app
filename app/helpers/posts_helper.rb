module PostsHelper

  def post_content(post) # TODO FL elnevezés: #truncated_content(?) - illetve 👀 String#truncate
    post.content.length > 200 ? "#{post.content[0..200]}..." : post.content
  end
end
