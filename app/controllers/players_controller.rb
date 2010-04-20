class PlayersController < ApplicationController
  
  before_filter :player, :only => [:show]
  def index
    @players = Player.all
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
