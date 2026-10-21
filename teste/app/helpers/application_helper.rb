module ApplicationHelper

  def menu(name, path)
    class_name = current_page?(path) ? 'active' : ''
    content_tag(:li, link_to(name, path), :class => class_name)
  end

end
