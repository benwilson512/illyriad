# == Schema Information
#
# Table name: calculations
#
#  id          :integer(4)      not null, primary key
#  name        :string(255)
#  type        :string(255)
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class NearestCalculation < Calculation
  def query(town, max_time, speed, alliances)
    max_time = max_time.to_i
    speed = speed.to_i
    @items = []
    max_distance = speed * max_time
    if !alliances.blank?
      Town.within_square_area(town,max_distance).each do |this_town|
        distance = town.distance_from(this_town.x, this_town.y)
        time = distance / speed
        if distance <= max_distance && town != this_town && alliances.include?(this_town.player.alliance)
          @items << {:distance => distance, :time => time, :town => this_town}
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
    
    @sorted = @items.sort_by { |item| item[:time] }
    
    return @sorted
  end
  # select p.name, a.ticker, t.pop, t.mapx, t.mapy, SQRT(POW(t.mapx)-<x center coord>,2)+POW(t.mapy-<y center coord>,2)) as range FROM towns t JOIN players p ON p.id = t.player_id LEFT JOIN alliances a ON p.alliance = a.id WHERE ticker in (<list of alliance tickers>) AND t.pop > <min pop here if you want> ORDER BY range ASC limit <max results>
  
end
