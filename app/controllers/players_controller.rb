class PlayersController < ApplicationController
  
  before_filter :player, :only => [:show]
  
  def index
    
  end
  
  def find
    case params[:search_type]
    when "name"
      name = params[:player_name]
      @player = Player.find_by_name name
    end
    redirect_to player_path @player
  end
  
  def show
    @alliance = @player.alliance
    @towns = @player.towns.all
  end
  
  private
  
    def player
      @player ||= Player.find(params[:id])
    end
    
end
