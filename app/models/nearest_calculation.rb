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
      puts "alliance"
      Town.within_square_area(town,max_distance).each do |this_town|
        distance = town.distance_from(this_town.x, this_town.y)
        time = distance / speed
        if distance <= max_distance && town != this_town && alliances.include?(this_town.player.alliance)
          @items << {:distance => distance, :time => time, :town => this_town}
        end
      end
    else
      puts "no alliance"
      Town.within_square_area(town,max_distance).each do |this_town|
        distance = town.distance_from(this_town.x, this_town.y)
        time = distance / speed
        if time < max_time && this_town != town
          @items << {:distance => distance, :time => time, :town => this_town}
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
