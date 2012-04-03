class CommentsController < ApplicationController
  before_filter :check_for_entity_id, :only => :index
  respond_to :json

  def index
    respond_with Entity.find(@entity_id).comments.to_json
  end

  def show
    respond_with Comment.find(params[:id]).to_json
  end

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
    end
  end
end
