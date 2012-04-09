class ProjectsController < ApplicationController
  before_filter :check_for_group_id, :only => [:index,:create]

  before_filter :authenticate_user!
  load_and_authorize_resource

  respond_to :json

  def index
    respond_with Group.find(params[:group_id]).projects
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
      params[:comment][:group_id] = @group_id if params[:comment]
    end
  end

#   def roles_to_current_user
#     user = current_user
# 
#     group = Project.find(params[:id]).try(:group)
#     roles = group ? current_user.roles_for(group) : []
# 
#     user.instance_eval do
#       @roles = lambda{roles}.call
#       def roles
#         @roles
#       end
#     end
# 
#     current_user = user
#   end
end
