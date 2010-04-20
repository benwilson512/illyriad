class NearestCalculation < Calculation
  def query(town, time, speed, alliances)
    time = time.to_i
    speed = speed.to_i
    @items = []
    @distance = speed * time
    if !alliances.blank?
      puts "alliance"
      Town.population_greater_than(100).x_less_than(town.x + @distance).x_greater_than(town.x - @distance).y_less_than(town.x + @distance).y_greater_than(town.x - @distance). each do |this_town|
        distance = Math.sqrt(((this_town.x-town.x)**2)+((this_town.y-town.y)**2))
        this_time = distance / speed
        if this_time < time && alliances.include?(this_town.player.alliance)
          @items << {:distance => distance, :time => this_time, :town => this_town}
        end
      end
    else
      puts "no alliance"
      Town.population_greater_than(100).x_less_than(town.x + @distance).x_greater_than(town.x - @distance).y_less_than(town.x + @distance).y_greater_than(town.x - @distance).each do |this_town|
        distance = Math.sqrt(((this_town.x-town.x)**2)+((this_town.y-town.y)**2))
        this_time = distance / speed
        if this_time < time
          @items << {:distance => distance, :time => this_time, :town => this_town}
        end
      end
    end
    
    @sorted = @items.sort_by { |item| item[:time] }
    
    # @sorted.each do |item|
    #   puts "Town: #{item[:town].name}"
    #   puts "Distance: #{item[:distance]}"
    #   puts "Time: #{item[:time]}"
    #   puts "----------"
    # end
    
    return @sorted
  end
  
  
end