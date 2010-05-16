class TownsController < ApplicationController
  
  before_filter :town, :except => [:index, :find]
  
  def index
    
  end
  
  def find
    case params[:search_type]
    when "coordinates"
      x_value = params[:x_field].to_i
      y_value = params[:y_field].to_i
      @town = Town.at_coordinates(x_value,y_value)[0]
    when "name"
      name = params[:town_name]
      @town = Town.by_name name
    end
    if @town.class == Town
      redirect_to town_path(@town)
    else
      @towns = @town
    end
  end
  
  def show
    
  end
  
  def near_town
    alliance = Alliance.find params[:alliance] if params[:alliance]
  end
  
  private
  
    def town
     @town ||= Town.find(params[:id])
    end
    
end
