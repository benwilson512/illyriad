require "rexml/document"
include REXML
doc = Document.new File.new("datafile_towns.xml")
doc.elements.each("towns/town/player/playeralliance") do |alliance|
  alliance_id = alliance.elements["alliancename"].attributes["id"]
  name = alliance.elements["alliancename"].text
  ticker = alliance.elements["allianceticker"].text
  if !Alliance.find_by_game_id(game_id)
    Alliance.create(:game_id => game_id, :name => name, :ticker => ticker)
  end
end
# doc.elements.each("towns/town/player") do |player|
#   game_id = player.elements["playername"].attributes["id"]
#   name = player.elements["playername"].text
#   
# end