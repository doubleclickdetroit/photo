class EntitiesController < ApplicationController
  before_filter :check_for_phase_id, :only => [:index,:create]

  before_filter :authenticate_user! 
  load_and_authorize_resource

  respond_to :json

  def index
    @entities = Entity.where(:phase_id => @phase_id).all.map &:to_hash
    respond_with @entities
  end

  def show
    @entity = Entity.find(params[:id]).to_hash
    respond_with @entity
  end

  def create
    respond_with Entity.spawn(params[:entity])
  end

  def update
    respond_with Entity.update(params[:id],params[:entity])
  end

  def destroy
    respond_with Entity.destroy(params[:id])
  end


private
  def check_for_phase_id
    if not @phase_id = params[:phase_id]
      respond_with :bad_request
    else
      params[:entity][:phase_id] = @phase_id if params[:entity]
    end
  end
end
