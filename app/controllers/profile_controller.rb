class ProfileController < ApplicationController
  def show
    @user = User.where(:name => params[:username]).first
  end
end
