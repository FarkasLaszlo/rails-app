module PostsHelper

  def truncated_content(post)
    post.content.length > 200 ? "#{post.content[0..200]}..." : post.content
  end
end
