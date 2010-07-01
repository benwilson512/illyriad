require 'rubygems'
require 'nokogiri'
require 'open-uri'

class Parser
  
  def self.parse!
    alliances = []
    players = []
    towns = []
    player_game_ids = []
    puts "working"  
    doc = Nokogiri::XML(File.open("#{RAILS_ROOT}/xml_blobs/datafile_towns.xml"))
    doc.xpath('towns/town').each do |town|
      tmp_town = {}
      tmp_alliance = {}
      tmp_player = {}
      town.children.each do |node|
        case node.name
        when "location"
          tmp_town[:mapx] = node.xpath("mapx").text
          tmp_town[:mapy] = node.xpath("mapy").text
        when "player"
          tmp_player[:game_id] = node.xpath("playername").attribute("id").value.to_i
          tmp_player[:name] = node.xpath("playername").text
          tmp_player[:race] = node.xpath("playerrace").text
          unless node.xpath("playeralliance").blank?
            tmp_alliance[:game_id] = node.xpath("playeralliance/alliancename").attribute("id").value.to_i
            tmp_alliance[:name] = node.xpath("playeralliance/alliancename").text
            tmp_alliance[:ticker] = node.xpath("playeralliance/allianceticker").text
            tmp_player[:alliance_game_id] = tmp_alliance[:game_id]
            alliances << tmp_alliance
          end
          players << tmp_player
        when "towndata"
          tmp_town[:game_id] = node.xpath("townname").attribute("id").value.to_i
          tmp_town[:name] = node.xpath("townname").text
          tmp_town[:population] = node.xpath("population").text
          tmp_town[:capital] = node.xpath("iscapital").text
          tmp_town[:alliance_capital] = node.xpath("isalliancecapital").text
          tmp_town[:player_game_id] = tmp_player[:game_id]
          towns << tmp_town
        end
      end
    end
    
    alliances.each do |alliance|
      puts "Creating Alliances"
      Alliance.create(:game_id => alliance[:game_id], 
                      :name => alliance[:name], 
                      :ticker => alliance[:ticker]) unless Alliance.find_by_game_id(alliance[:game_id])
    end
    
    players.each do |player|
      puts "Creating Players"
      alliance_id = Alliance.find_by_game_id(player[:alliance_game_id])
      Player.create(:name => player[:name], 
                    :game_id => player[:game_id], 
                    :race => player[:race], 
                    :alliance_id => alliance_id) unless Player.find_by_game_id(player[:game_id])
    end
    
    towns.each do |town|
      puts "Creating Towns"
      player_id = Player.find_by_game_id(town[:player_game_id])
      Town.create(:x => town[:mapx], 
                  :y => town[:mapy], 
                  :name => town[:name], 
                  :population => town[:population], 
                  :capital => town[:capital], 
                  :alliance_capital => town[:alliance_capital], 
                  :game_id => town[:game_id], 
                  :player_id => player_id) #no unless here because there aren't duplicate town entries
    end
    
  end
  
end