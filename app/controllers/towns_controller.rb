class TownsController < ApplicationController
  
  before_filter :town, :except => [:index, :find]
  before_filter :siege
  
  def index
    case params[:search_type]
    when "coordinates"
      x_value = params[:x_field].to_i
      y_value = params[:y_field].to_i
      @town = Town.at_coordinates(x_value,y_value).first
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
  
  def select_as_target
    @siege = find_siege
    @siege.add_target(@town)
    redirect_to towns_path
  end
  
  def add_to_siege
    puts params.inspect
  end
  
  private
  
    def find_siege
      session[:siege] ||= Siege.new
    end
  
    def town
     @town ||= Town.find(params[:id])
    end
    
    def siege
      @siege = session[:siege]
    end
    
end
