class AlliancesController < ApplicationController
  
  before_filter :alliance, :except => [:index]
  
  def index
    @alliances = Alliance.by_name.paginate :page => params[:page]
  end

  def show
    @players = alliance.players.by_name
  end
  
  private
   
   def alliance
     @alliance ||= Alliance.find(params[:id])
   end

end
