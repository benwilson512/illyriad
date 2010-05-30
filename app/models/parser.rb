require "rexml/document"
include REXML

class Parser
  
  def self.parse!
    start = Time.now
    self.create_alliances!
    self.create_players!
    self.create_towns!
    finish = Time.now
    diff = finish - start
    puts "Seconds: #{diff}"
    objects_created = Alliance.all.size + Ownership.all.size + Town.all.size + Player.all.size
    puts "Objects Created: #{objects_created}"
  end
    
  
  def self.create_alliances!
    puts "Creating Alliances"
    doc = Document.new File.new("xml_blobs/datafile_towns.xml")
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
    puts "Creating Players"
    doc = Document.new File.new("xml_blobs/datafile_towns.xml")
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
    puts "Creating Towns"
    doc = Document.new File.new("xml_blobs/datafile_towns.xml")
    doc.elements.each("towns/town") do |town|
      game_id = town.elements["towndata/townname"].attributes["id"]
      owner = Player.find_by_game_id town.elements["player/playername"].attributes["id"]
        name = town.elements["towndata/townname"].text
        population = town.elements["towndata/population"].text
        capital = town.elements["towndata/iscapitalcity"].text.to_i == 1 ? true : false
        alliance_capital = town.elements["towndata/isalliancecapitalcity"].text.to_i == 1 ? true : false
        x = town.elements["location/mapx"].text
        y = town.elements["location/mapy"].text
        owner = Player.find_by_game_id town.elements["player/playername"].attributes["id"]
        owner.towns.create(:name => name, :game_id => game_id, :population => population, :capital => capital, :alliance_capital => alliance_capital, :x => x, :y => y)
      end
    nil
  end
  
  def self.query
    xmin = -55
    xmax = 40.6
    ymin = -36
    ymax = 60
    xavg = -7.4
    yavg = 12
    towns = Town.x_less_than(xmax).x_greater_than(xmin).y_less_than(ymax).y_greater_than(ymin)
    harmless = Alliance.find_by_name("Harmless?")
    towns = towns.select { |town| town if town.player.alliance == harmless }
    items = []
    towns.each do |town|
      distance = town.distance_from(xavg, yavg)
      time = distance / 4
      items << {:town => town, :time => time}
    end
    puts "towns"
    puts towns.size
    puts "items"
    puts items.size
    puts "----"
    items = items.sort_by { |item| item[:time] }
    items.each do |item|
      puts "Player: #{item[:town].player.name} -- Town: #{item[:town].name} -- Population: #{item[:town].population} -- Time: #{item[:time]}"
    end
  end
  
  def self.average
    total = 0
    distances = []
    # towns = Town.all.select { |town| town if (rand >= 0.95) }
    towns = Town.population_greater_than(1000)
    towns = towns.select{|town| town if town.player.alliance}
    towns.each do |town|
      towns.each do |town_prime|
        total += 1
        distances << town.distance_from(town_prime.x,town_prime.y)
      end
    end
    puts "total: #{total}"
    # puts "total_distance: #{total_distance}"
    # average = total_distance / total
    puts (distances.size/2).to_i
    distances.sort!
    median = distances[(distances.length/2).to_i]
    puts "median: #{median}"
  end
  
end