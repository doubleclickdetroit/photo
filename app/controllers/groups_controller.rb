class GroupsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  # todo maybe doing something wrong with CanCan here...
  skip_authorize_resource :only => [:create]

  respond_to :json

  def index
    @groups = current_user.groups.map(&:to_hash) 
    respond_with @groups
  end

  def show
    @group = Group.find(params[:id]).to_hash
    respond_with @group
  end

  def create
    @group = Group.create(params[:group])
    @hash  = @group.to_hash
    respond_with @hash, :location => @group
  end

  def update
    respond_with Group.update(params[:id],params[:group]).to_hash
  end

  def destroy
    respond_with Group.destroy(params[:id]).to_hash
  end

  # # GET /groups
  # # GET /groups.json
  # def index
  #   @groups = current_user ? current_user.groups : []

  #   respond_to do |format|
  #     format.html # index.html.erb
  #     format.json { render json: @groups }
  #   end
  # end

  # # GET /groups/1
  # # GET /groups/1.json
  # def show
  #   @group = Group.find(params[:id])

  #   respond_to do |format|
  #     format.html # show.html.erb
  #     format.json { render json: @group }
  #   end
  # end

  # # GET /groups/new
  # # GET /groups/new.json
  # def new
  #   @group = Group.new

  #   respond_to do |format|
  #     format.html # new.html.erb
  #     format.json { render json: @group }
  #   end
  # end

  # # GET /groups/1/edit
  # def edit
  #   @group = Group.find(params[:id])
  # end

  # # POST /groups
  # # POST /groups.json
  # def create
  #   # params[:group][:members] = [current_user]
  #   @user  = current_user
  #   @group = Group.new(params[:group])

  #   respond_to do |format|
  #     if @group.save
  #       @user.enroll_in @group, :as => :owner

  #       format.html { redirect_to @group, notice: 'Group was successfully created.' }
  #       format.json { render json: @group, status: :created, location: @group }
  #     else
  #       format.html { render action: "new" }
  #       format.json { render json: @group.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # PUT /groups/1
  # # PUT /groups/1.json
  # def update
  #   @group = Group.find(params[:id])

  #   respond_to do |format|
  #     if @group.update_attributes(params[:group])
  #       format.html { redirect_to @group, notice: 'Group was successfully updated.' }
  #       format.json { head :ok }
  #     else
  #       format.html { render action: "edit" }
  #       format.json { render json: @group.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # DELETE /groups/1
  # # DELETE /groups/1.json
  # def destroy
  #   @group = Group.find(params[:id])
  #   @group.destroy

  #   respond_to do |format|
  #     format.html { redirect_to groups_url }
  #     format.json { head :ok }
  #   end
  # end
end
