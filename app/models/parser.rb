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
    doc = Nokogiri::XML(File.open("#{Rails.root}/xml_blobs/datafile_towns.xml"))
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
    
    puts "Creating Alliances"
    alliances.each do |alliance|
      Alliance.create(:game_id => alliance[:game_id], 
                      :name => alliance[:name], 
                      :ticker => alliance[:ticker])
    end
    
    puts "Creating Players"
    players.each do |player|
      alliance = Alliance.find_by_game_id(player[:alliance_game_id])
      alliance ? alliance_id = alliance.id : Alliance.find_by_game_id(-1).id
      Player.create(:name => player[:name], 
                    :game_id => player[:game_id], 
                    :race => player[:race], 
                    :alliance_id => alliance_id)
    end
    
    puts "Creating Towns"
    towns.each do |town|
      player_id = Player.find_by_game_id(town[:player_game_id]).id
      Town.create(:x => town[:mapx], 
                  :y => town[:mapy], 
                  :name => town[:name], 
                  :population => town[:population], 
                  :capital => town[:capital], 
                  :alliance_capital => town[:alliance_capital], 
                  :game_id => town[:game_id], 
                  :player_id => player_id)
    end
    
  end
  
  # def create_smaller_sample
  #   doc = Nokogiri::XML(File.open("#{Rails.root}/xml_blobs/datafile_towns.xml"))
  #   
  #   doc.xpath('towns/town').each_with_index do |town,i|
  #     i % 100 == 0 ? xml << town
  #   end
  # end
  
end