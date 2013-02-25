module ApplicationHelper
  def full_title(page_title)
    base_title = "PMON"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def is_active(action)
    params[:action] == action ? "active" : nil
  end

  def render_404
    raise ActionController::RoutingError.new('Nie ma takiej strony')
  end

end