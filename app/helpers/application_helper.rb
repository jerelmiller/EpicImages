module ApplicationHelper

  def current_page_class(path)
    'currentPage' if request.path.eql? path
  end

  def format_time(time)
    time.strftime '%A, %B %-d, %Y'
  end
end