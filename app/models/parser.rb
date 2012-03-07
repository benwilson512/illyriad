require 'rubygems'
require 'nokogiri'
require 'open-uri'

class Parser
  
  def self.parse_towns!
    alliances = []
    players = []
    towns = []
    player_ids = []
    puts "working"  
    doc = Nokogiri::XML(File.open("#{Rails.root}/xml_blobs/datafile_towns.xml"))
    doc.xpath('towns/town').each do |town|
      tmp_town = {}
      tmp_alliance = {}
      tmp_player = {}
      town.children.each do |node|
        case node.name
        when "location"
          tmp_town[:mapx] = node.child.text.to_i
          tmp_town[:mapy] = node.child.next.text.to_i
        when "player"
          tmp_player[:id] = node.xpath("playername").attribute("id").value.to_i
          tmp_player[:name] = node.xpath("playername").text
          tmp_player[:race] = node.xpath("playerrace").text
          unless node.xpath("playeralliance").blank?
            tmp_alliance[:id] = node.xpath("playeralliance/alliancename").attribute("id").value.to_i
            tmp_alliance[:name] = node.xpath("playeralliance/alliancename").text
            tmp_alliance[:ticker] = node.xpath("playeralliance/allianceticker").text
            tmp_player[:alliance_id] = tmp_alliance[:id]
            alliances << tmp_alliance
          end
          tmp_player[:alliance_id] = 0 unless tmp_player[:alliance_id]
          players << tmp_player
        when "towndata"
          tmp_town[:id] = node.xpath("townname").attribute("id").value.to_i
          tmp_town[:name] = node.xpath("townname").text
          tmp_town[:population] = node.xpath("population").text
          tmp_town[:capital] = node.xpath("iscapital").text == "true" ? 1 : 0
          tmp_town[:alliance_capital] = node.xpath("isalliancecapital").text == "true" ? 1 : 0
          tmp_town[:player_id] = tmp_player[:id]
          towns << tmp_town
        end
      end
    end
    
    sql = ActiveRecord::Base.connection()
    
    time = Time.now
    
    puts "Creating Alliances..."
    alliances.each do |alliance|
      sql.execute ("INSERT IGNORE INTO alliances (id, name, ticker, created_at)
        VALUES ('%i',\"%s\",\"%s\",'%s' )" % [alliance[:id], strip_tags(alliance[:name]), strip_tags(alliance[:ticker]), time])
    end
    
    puts "Creating Players..."
    players.each do |player|
      sql.execute ("INSERT IGNORE INTO players (id, name, race, alliance_id, created_at)
        VALUES ('%i',\"%s\",\"%s\",'%i','%s' )" % [player[:id], strip_tags(player[:name]), player[:race], player[:alliance_id], time])
    end
    
    puts "Creating Towns..."
    towns.each do |town|
      sql.execute ("INSERT IGNORE INTO towns (alliance_capital, capital, created_at, id, name, player_id, population, x, y) 
        VALUES (%i,%i,'%s',%i,\"%s\",%i,%i,%i,%i)" % [town[:alliance_capital], town[:capital], time, town[:id], strip_tags(town[:name]), town[:player_id], town[:population], town[:mapx], town[:mapy]])
    end
    
  end
  
  def self.strip_tags(string)
    string.gsub(/\\/, '\&\&').gsub(/'/, "''")
  end
  
  def self.parse_alliances!
    relationships = []
    alliances = []
    doc = Nokogiri::XML(File.open("#{Rails.root}/xml_blobs/datafile_alliances.xml"))
    doc.xpath("alliancedata/alliances/alliance").each do |alliance|
      tmp_alliance = {}
      tmp_alliance[:id] = alliance.xpath("alliance").attribute("id").value.to_i
      tmp_alliance[:name] = alliance.xpath("alliance").text
      tmp_alliance[:founder_id] = alliance.xpath("foundedbyplayerid").attribute("id").value.to_i
      tmp_alliance[:capital_id] = alliance.xpath("alliancecapitaltownid").attribute("id").value.to_i
      tmp_alliance[:ticker] = alliance.xpath("allianceticker").text
      tmp_alliance[:founded] = alliance.xpath("foundeddatetime").text
      tmp_alliance[:tax_rate] = alliance.xpath("alliancetaxrate").text
      tmp_alliance[:tax_set_date] = alliance.xpath("alliancetaxratelastchanged").text
      tmp_alliance[:total_population] = alliance.xpath("totalpopulation").text
      alliance.xpath("relationships/relationship").each do |relationship|
        tmp_relationship = {}
        tmp_relationship[:proposed_by_id] = relationship.xpath("proposedbyalliance").attribute("id").value.to_i
        tmp_relationship[:accepted_by_id] = relationship.xpath("acceptedbyalliance").attribute("id").value.to_i
        tmp_relationship[:type_id] = relationship.xpath("relationshiptype").attribute("id").value.to_i
        tmp_relationship[:established] = relationship.xpath("establishedsince").text
        
        relationships << tmp_relationship
      end
      alliances << tmp_alliance
    end
    
    alliances.each do |alliance|
      existing_alliance = Alliance.find_by_id(alliance[:id])
      if existing_alliance
        existing_alliance.update_attributes(:name => alliance[:name],
                                            :founder_id => alliance[:founder_id],
                                            :capital_id =>alliance[:capital_id],
                                            :ticker => alliance[:ticker],
                                            :founded => alliance[:founded],
                                            :tax_rate => alliance[:tax_rate],
                                            :total_population => alliance[:total_population])
                                          end
      
    end
    
    puts alliances.size
    puts relationships.size
    nil
  end
  
  # def create_smaller_sample
  #   doc = Nokogiri::XML(File.open("#{Rails.root}/xml_blobs/datafile_towns.xml"))
  #   
  #   doc.xpath('towns/town').each_with_index do |town,i|
  #     i % 100 == 0 ? xml << town
  #   end
  # end
  
end