class ProjectsController < ApplicationController
  before_filter :authenticate_user! #, :roles_to_current_user
  load_and_authorize_resource

  respond_to :json

  def index
    # respond_with Project.by_group(params[:group_id])
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

# private
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
