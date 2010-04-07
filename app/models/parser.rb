require "rexml/document"
include REXML

class Parser
  
  @@doc = Document.new File.new("xml_blobs/datafile_towns.xml")
  
  def self.parse!
    self.create_alliances!
    self.create_players!
    self.create_towns!
  end
    
  
  def self.create_alliances!
    doc = @@doc
    doc.elements.each("towns/town/player/playeralliance") do |alliance|
      game_id = alliance.elements["alliancename"].attributes["id"]
      unless Alliance.find_by_game_id(game_id)
      name = alliance.elements["alliancename"].text
      ticker = alliance.elements["allianceticker"].text
      Alliance.create(:game_id => game_id, :name => name, :ticker => ticker)
      end
    end
    nil
  end
  
  def self.create_players!
    doc = @@doc
    doc.elements.each("towns/town/player") do |player|
      game_id = player.elements["playername"].attributes["id"]
      unless Player.find_by_game_id(game_id)
        name = player.elements["playername"].text
        race = player.elements["playerrace"].text
        if player.elements["playeralliance/alliancename"]
          alliance = Alliance.find_by_game_id(player.elements["playeralliance/alliancename"].attributes["id"])
          alliance.players.create(:game_id => game_id, :name => name, :race => race)
        else
          Player.create(:game_id => game_id, :name => name, :race => race)
        end
      end
    end
    nil
  end
  
  def self.create_towns!
    doc = @@doc
    doc.elements.each("towns/town") do |town|
      game_id = town.elements["towndata/townname"].attributes["id"]
      unless Town.find_by_game_id(game_id)
        name = town.elements["towndata/townname"].text
        population = town.elements["towndata/population"].text
        capital = town.elements["towndata/iscapitalcity"].text.to_i == 1 ? true : false
        alliance_capital = town.elements["towndata/isalliancecapitalcity"].text.to_i == 1 ? true : false
        x = town.elements["location/mapx"].text
        y = town.elements["location/mapy"].text
        owner = Player.find_by_game_id town.elements["player/playername"].attributes["id"]
        owner.towns.create(:name => name, :game_id => game_id, :population => population, :capital => capital, :alliance_capital => alliance_capital, :x => x, :y => y)
      end
    end
    nil
  end
  
  def self.the_doc
    puts @@doc
  end
  
end