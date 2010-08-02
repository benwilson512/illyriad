class SiegeForcesController < ApplicationController
  
  def update
    @force = SiegeForce.find(params[:id])
    @force.update_attributes(params[:siege_force])
    redirect_to siege_path(params[:siege_id])
  end
  
end