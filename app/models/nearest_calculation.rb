class NearestCalculation < Calculation
    
  def query(params)
    input_time = params[:time].to_i
    input_speed = params[:speed].to_i
    input_town = Town.find(params[:town_id])
    puts input_time.inspect, input_speed.inspect
    max_distance = input_speed * input_time
    alliances = params[:alliances].split(", ").collect { |name| Alliance.find_by_name(name) }
    
    @items = []
    
    if !alliances.blank?
      Town.within_square_area(input_town,max_distance).population_greater_than(5000).each do |this_town|
        distance = input_town.distance_from(this_town.x, this_town.y)
        this_time = distance / input_speed
        if distance <= max_distance && input_town != this_town && alliances.include?(this_town.player.alliance)
          @items << {:distance => distance, :time => this_time, :town => this_town}
        end
      end
    else
      Town.within_square_area(town,max_distance).each do |this_town|
        distance = town.distance_from(this_town.x, this_town.y)
        time = distance / speed
        if time < max_time && this_town != town
          @items << {:distance => distance, :time => time, :town => this_town}
        end
      end
    end
    
    sorted = @items.sort_by { |item| item[:time] }
    return sorted
  end
  # select p.name, a.ticker, t.pop, t.mapx, t.mapy, SQRT(POW(t.mapx)-<x center coord>,2)+POW(t.mapy-<y center coord>,2)) as range FROM towns t JOIN players p ON p.id = t.player_id LEFT JOIN alliances a ON p.alliance = a.id WHERE ticker in (<list of alliance tickers>) AND t.pop > <min pop here if you want> ORDER BY range ASC limit <max results>
  
end