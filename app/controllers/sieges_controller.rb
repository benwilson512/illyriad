class SiegesController < ApplicationController
  
  before_filter :siege, :except => [:index, :new, :create, :update]
  
  def index
    @active_siege = session[:siege]
    @sieges = Siege.all
  end
  
  def show
    @target = @siege.target
    @arrival_times = {}
    @reinforcements = SiegeForce.for_siege(@siege.id).with_role('reinforcements')
    @arrival_times[:reinforcements] = @siege.time + @siege.reinforce_time_delta
    @siege_forces = SiegeForce.for_siege(@siege.id).with_role('siege_forces')
    @clearing_forces = SiegeForce.for_siege(@siege.id).with_role('clearing_forces')
    @arrival_times[:clearing_forces] = @siege.time - @siege.clearing_force_time_delta
  end
  
  def update
    @siege = Siege.new(params[:siege])
    @siege.save
    redirect_to siege_path(@siege) 
  end
  
  def activate
    session[:siege] = siege
    flash[:notice] = "Activated!"
    redirect_to towns_path
  end
  
  def new
    if params[:town_id]
      @town = Town.find(params[:town_id])
      @siege = Siege.new(:target_id => @town.id, :time => (Time.now + 2.days) )
    else
      flash[:alert] = "First select a town to siege"
      redirect_to towns_path
    end
  end
  
  def create
    @siege = Siege.new(params[:siege].merge!(:creator_id => current_user.id))
    if @siege.save
      flash[:notice] = "Siege created, browse for towns you wish to add as attackers"
      session[:siege] = @siege
      redirect_to towns_path
    else
      flash[:error] = "There was an error, go yell at Larry"
      redirect_to root_path
    end
  end
  
  private
  
    def town
      @town ||= Town.find(params[:town_id])
    end
    
    def siege
      @siege = Siege.find(params[:id])
    end
end
