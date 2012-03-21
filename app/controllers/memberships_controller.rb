class MembershipsController < ApplicationController
  # todo controller auth 
  respond_to :json

  # def index
  #   respond_with Membership.all
  # end

  # def show
  #   respond_with Membership.find(params[:id])
  # end

  # def update
  #   respond_with Membership.update(params[:id],params[:membership])
  # end

  def create
    respond_with Membership.create(params[:membership])
  end

  def destroy
    respond_with Membership.destroy(params[:id])
  end
end
