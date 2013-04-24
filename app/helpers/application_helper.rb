module ApplicationHelper

  def current_page_class(path)
    'currentPage' if request.path.eql? path
  end

  def format_time(time)
    time.strftime '%A, %B %-d, %Y'
  end

  def submit_text(model)
    return "Create #{model}" if params[:action].eql? 'new'
    "Update #{model}"
  end
end