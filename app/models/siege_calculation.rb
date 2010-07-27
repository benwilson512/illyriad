
class SiegeCalculation < Calculation  
  
  def query(alliance, target_alliance, time)
    time = time.to_i
    @items = []
    @distance = 4 * time
    
    alliance.players.each do |player|
      player.towns.each do |town|
        targets = []
        Town.x_less_than(town.x + @distance).x_greater_than(town.x - @distance).y_less_than(town.y + @distance).y_greater_than(town.y - @distance). each do |target_town|
          distance = Math.sqrt(((target_town.x-town.x)**2)+((target_town.y-town.y)**2))
          this_time = distance / speed
          if this_time < time && alliances.include?(this_town.player.alliance)
            targets << {:distance => distance, :time => this_time, :target_town => target_town}
          end
        end
        @items << {:town => town, :targets => targets}
      end
    end
    
    @items.each do |item|
      puts item
    end
  end
end
