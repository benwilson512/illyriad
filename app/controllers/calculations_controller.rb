class CalculationsController < ApplicationController
  
  before_filter :authenticate_user!
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
    calculation_type = Calculation.find_by_type params[:calculation_type]
    max_results = params[:max_results].to_i
    @town = Town.find(params[:town_id])
    
    @report_items = calculation_type.query(params)
    # @reinforcements = @town.find_reinforcements(params)
    
    if max_results > 0
      @report_items = @report_items.slice(0,max_results)
      # @reinforcements = @reinforcements.slice(0,max_results)
    end
    
  end
  
  private
  
    def calculation
      @calculation ||= Calculation.find params[:id]
    end

end
