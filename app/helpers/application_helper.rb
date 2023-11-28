module ApplicationHelper
  include Pagy::Frontend
  
  def transparent_button
    cookies[:theme].in?(["light-mode", nil]) ? "btn-light" : "btn-dark"
  end
end
