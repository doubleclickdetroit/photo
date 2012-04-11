class ProjectsController < ApplicationController
  before_filter :check_for_group_id, :only => [:index,:create]

  before_filter :authenticate_user!
  load_and_authorize_resource

  respond_to :json

  def index
    projects = Group.find(params[:group_id]).projects
    respond_with projects.map(&:to_hash).to_json
  end

  def show
    respond_with Project.find(params[:id]).to_json
  end

  def create
    respond_with Project.create(params[:project]).to_json
  end

  def update
    respond_with Project.update(params[:id],params[:project]).to_json
  end

  def destroy
    respond_with Project.destroy(params[:id]).to_json
  end

private
  def check_for_group_id
    if not @group_id = params[:group_id]
      respond_with :bad_request
    else
      params[:project][:group_id] = @group_id if params[:project]
    end
  end
end
