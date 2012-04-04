class WatchingsController < ApplicationController
  before_filter :check_for_entity_id, :only => [:index,:create]

  before_filter :authenticate_user!
  load_and_authorize_resource

  respond_to :json

  # def index
  #   respond_with Entity.find(@entity_id).watchings.to_json
  # end

  # def show
  #   respond_with Watching.find(params[:id]).to_json
  # end

  def create
    respond_with Watching.create(params[:watching]).to_json
  end

  # def update
  #   respond_with Watching.update(params[:id],params[:watching]).to_json
  # end

  def destroy
    respond_with Watching.destroy(params[:id]).to_json
  end


private
  def check_for_entity_id
    if not @entity_id = params[:entity_id]
      respond_with :bad_request
    else
      params[:watching][:entity_id] = @entity_id if params[:watching]
    end
  end
end
