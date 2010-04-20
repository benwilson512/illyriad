class Stats
  
  def self.extreme_coords
    puts "Maximum x: #{max_x}"
    puts "Minimum x: #{min_x}"
    puts "Maximum y: #{max_y}"
    puts "Minimum y: #{min_y}"
  end
  
  def closest_in_alliances(coordinates, [alliances])
    alliances.each do |alliance|
      
  
  def self.max_x
    x = 0
    Town.all.each do |town|
      unless town.x == 1000
        town.x > x ? x = town.x : x
      end
    end
    x
  end
  
  def self.min_x
    x = 0
    Town.all.each do |town|
      town.x < x ? x = town.x : x
    end
    x
  end
  
  def self.max_y
    y = 0
    Town.all.each do |town|
      unless town.x == 1000
        town.y > y ? y = town.y : y
      end
    end
    y
  end
  
  def self.min_y
    y = 0
    Town.all.each do |town|
      town.y < y ? y = town.y : y
    end
    y
  end
  
end