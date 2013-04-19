module ApplicationHelper

  def current_page_class(path)
    'currentPage' if request.path.eql? path
  end
end
