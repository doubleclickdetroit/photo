class WatchingsController < ApplicationController
  before_filter :check_for_entity_id, :only => :create

  before_filter :authenticate_user!
  load_and_authorize_resource

  respond_to :json

  def create
    respond_with Watching.create(params[:watching]).to_json
  end

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
