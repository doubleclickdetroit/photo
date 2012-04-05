class InvitationsController < ApplicationController
  before_filter :check_for_group_id, :only => [:create,:index]

  respond_to :json

  def create
    respond_with Invitation.create(params[:invitation]).to_json
  end

  def index
    respond_with Group.find(@group_id).invitations.to_json
  end

  def show
    respond_with Invitation.find(params[:id])
  end

  def destroy
    respond_with Invitation.destroy(params[:id]).to_json
  end


private
  def check_for_group_id
    if not @group_id = params[:group_id]
      respond_with :bad_request
    else
      if params[:invitation]
        params[:invitation][:group_id] = @group_id
        params[:invitation][:inviter_id] = current_user.to_param
      end
    end
  end
end
