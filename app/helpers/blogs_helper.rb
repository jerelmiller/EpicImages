module BlogsHelper

  def read_more_link(blog)
    link_to 'READ MORE &rarr;'.html_safe, blog_path(blog) if blog.body.length > Blog::TRUNCATE_LENGTH
  end
end