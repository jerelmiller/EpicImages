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

  def cancel_button(options = {})
    classes = options[:class].try(:concat, ' red') || 'red'
    button options.merge(class: classes) do
      concat content_tag :span, '', class: 'icon16 cross'
      concat 'Cancel'
    end
  end

  def link_to_cancel(path)
    link_to path, class: 'button red' do
      concat content_tag :span, '', class: 'icon16 cross'
      concat 'Cancel'
    end
  end

  def search_button(extra_classes = nil)
    button(class: extra_classes) do
      concat content_tag :span, '', class: 'glyph search'
      concat 'Search'
    end
  end

  private

    def button(options = {}, &block)
      options[:class] = options[:class].try(:concat, ' button') || 'button'
      content_tag(:button, options) do
        yield
      end
    end

end