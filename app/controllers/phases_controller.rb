class PhasesController < ApplicationController
  before_filter :check_for_project_id, :only => [:index,:create]

  before_filter :authenticate_user! 
  load_and_authorize_resource

  respond_to :json

  def index
  end

  def show
  end

  def create
  end

  def update
  end

  def destroy
  end

  # def index
  #   respond_with Phase.by_project(params[:project_id])
  # end

  # def show
  #   respond_with Phase.find(params[:id]).to_json
  # end

  # def create
  #   respond_with Phase.create(params[:phase]).to_json
  # end

  # def update
  #   respond_with Phase.update(params[:id],params[:phase]).to_json
  # end

  # def destroy
  #   respond_with Phase.destroy(params[:id]).to_json
  # end

private
  def check_for_project_id
    if not @project_id = params[:project_id]
      respond_with :bad_request
    else
      params[:phase][:project_id] = @project_id if params[:phase]
    end
  end
end
