class PlayersController < ApplicationController
  
  before_filter :player, :only => [:show]
  
  def index
    @player = Player.find_by_name(params[:player_name])
    if @player
      redirect_to player_path(@player)
    elsif params[:search_type]
      flash[:error] = "Could not find a player with that exact name"
    end
  end
  
  def show
    @towns = @player.towns.all
  end
  
  private
  
    def player
      @player ||= Player.find(params[:id])
    end
    
end
