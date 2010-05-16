# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def link_to_alliance(player)
    player.alliance ? link_to(player.alliance.name, alliance_path(player.alliance)) : "No Alliance"
  end
end
