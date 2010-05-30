class StatisticsController < ApplicationController
  caches_page :index
  
  def index
    # @towns = Town.population_greater_than(150)
    # @median = median_distance(@towns)
    # @mean = mean_distance(@towns)
    # @mode = mode(@towns)
    @median = 260
    @mean = 274
    @large_towns = Town.population_greater_than(1000).size
    
  end
  
  private
  
    def median_distance_by_population(population)
      towns = Town.population_greater_than(population)
      median_distance(towns)
    end
    
    def get_distances(towns)
      @distances ||= []
      if @distances.blank?
        towns.each do |town|
          towns.each do |town_prime|
            @distances << town.distance_from(town_prime.x,town_prime.y)
          end
        end
        return @distances.sort!
      else
        return @distances
      end
    end
  
    def median_distance(towns)
      distances = get_distances(towns)
      median = distances[(distances.length/2).to_i]
    end
    
    def mean_distance(towns)
      distances = get_distances(towns)
      total = distances.size
      total_distance = 0
      distances.each do |distance|
        total_distance += distance
      end
      average = total_distance / total
    end
    
    # def mode(towns)
    #   distances = get_distances(towns)
    #   distances.map{|distance| (distance/10).to_i * 10}
    #   
    # end
    
end
