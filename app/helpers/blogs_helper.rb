module BlogsHelper

  def blog_content(blog)
    blog.content.length > 200 ? "#{blog.content[0..200]}..." : blog.content
  end

  def blog_author(blog)
    User.find_by(serial: blog.author)&.name || "User not found"
  end

end
