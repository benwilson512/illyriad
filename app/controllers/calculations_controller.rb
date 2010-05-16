class CalculationsController < ApplicationController
  
  before_filter :calculation, :except => [:index]
  
  def index
    
  end
  
  def options
    params.each do |param|
      case param
      when "town_id"
        town = Town.find params[param.to_sym]
        @town = town if town
      end
    end
  end
  
  def results
    @town = Town.find params[:town_id]
    time = params[:time]
    @speed = params[:speed]
    alliances = params[:alliances].split(", ").collect { |name| Alliance.find_by_name(name) }
    calculation_type = Calculation.find_by_type params[:calculation_type]
    max_results = params[:max_results].to_i
    
    @report_items = calculation_type.query @town, time, @speed, alliances
    @reinforcements = @town.find_reinforcements time, @speed if @town.player.alliance
    
    if max_results > 0
      @report_items = @report_items.slice(0,max_results)
      @reinforcements = @reinforcements.slice!(0,max_results)
    end
    
  end
  
  private
  
    def calculation
      @calculation ||= Calculation.find params[:id]
    end

end
