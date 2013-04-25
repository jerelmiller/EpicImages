module ApplicationHelper

  def current_page_class(path)
    'currentPage' if request.path.eql? path
  end

  def format_time(time)
    time.strftime '%A, %B %-d, %Y'
  end

  def save_button
    button do
      concat content_tag :span, '', class: 'glyph save'
      concat 'Save'
    end
  end

  def link_to_cancel(path)
    link_to path, class: 'button red' do
      concat content_tag :span, '', class: 'icon16 cross'
      concat 'Cancel'
    end
  end

  def search_button(extra_classes = nil)
    button(extra_classes) do
      concat content_tag :span, '', class: 'glyph search'
      concat 'Search'
    end
  end

  private

    def button(extra_classes = nil, &block)
      content_tag :button, class: "button #{extra_classes}" do
        yield
      end
    end

end