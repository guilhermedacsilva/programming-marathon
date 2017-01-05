module ApplicationHelper
  def show_top_menu?
    !current_page?('/login')
  end
end
