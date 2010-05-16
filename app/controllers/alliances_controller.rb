class AlliancesController < ApplicationController
  
  def index
    @alliances = Alliance.all
  end

  def show
    @alliance = Alliance.find(params[:id])
  end

end
