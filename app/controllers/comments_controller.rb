class CommentsController < ApplicationController
  before_filter :check_for_entity_id, :only => :create

  before_filter :authenticate_user!
  load_and_authorize_resource

  respond_to :json

  def create
    respond_with Comment.create(params[:comment]).to_json
  end

  def update
    respond_with Comment.update(params[:id],params[:comment]).to_json
  end

  def destroy
    respond_with Comment.destroy(params[:id]).to_json
  end


private
  def check_for_entity_id
    if not @entity_id = params[:entity_id]
      respond_with :bad_request
    else
      params[:comment][:entity_id] = @entity_id if params[:comment]
    end
  end
end
