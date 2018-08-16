module BlogsHelper

  def blog_content(blog)
    blog.content.length > 200 ? "#{blog.content[0..200]}..." : blog.content
  end

end
