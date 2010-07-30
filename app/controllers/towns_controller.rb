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
  
  def add_to_siege
    puts params.inspect
    troops = params[:troops]
    role = params[:role]
    destination = params[:destination].split(',').first
    x = params[:destination].split(',')[1]
    y = params[:destination].split(',')[2]
    speed = params[:speed]
    puts "speed: #{speed.to_f}"
    @town.siege_forces.create!(:siege => @siege, :troops => troops, :role => role, :destination_x => x, :destination_y => y, :speed => speed, :destination => destination)
    redirect_to root_path
  end
  
  private
  
    def town
     @town ||= Town.find(params[:id])
    end
    
    def siege
      @siege = session[:siege]
    end
    
end
