require 'google_visualization'
include Google::Visualization

class TownsController < ApplicationController
  
  def index
    @x_values = Town.all.collect { |town| town.x }
    @y_values = Town.all.collect { |town| town.y }
    
    
  end
  
  def show
  end

end
