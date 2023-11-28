module ApplicationHelper
  def transparent_button
    cookies[:theme] == "light-mode" ? "btn-light" : "btn-dark"
  end
end
