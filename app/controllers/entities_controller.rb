class EntitiesController < ApplicationController
  before_filter :authenticate_user! #, :roles_to_current_user
  load_and_authorize_resource
  skip_authorize_resource :only => :new

  # GET /entities
  # GET /entities.json
  def index
    @entities = Entity.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @entities }
    end
  end

  # GET /entities/1
  # GET /entities/1.json
  def show
    @entity = Entity.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @entity }
    end
  end

  # GET /entities/new
  # GET /entities/new.json
  def new
    @entity = Entity.new :project_id => params[:project_id]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @entity }
    end
  end

  # GET /entities/1/edit
  def edit
    @entity = Entity.find(params[:id])
  end

  # POST /entities
  # POST /entities.json
  def create
    @entity = Entity.spawn(params[:entity])

    respond_to do |format|
      if @entity.save
        format.html { redirect_to @entity.project, notice: "#{@entity.type} was successfully created." }
        format.json { render json: @entity, status: :created, location: @entity }
      else
        format.html { render action: "new" }
        format.json { render json: @entity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /entities/1
  # PUT /entities/1.json
  def update
    @entity = Entity.find(params[:id])

    respond_to do |format|
      if @entity.update_attributes(params[:entity])
        format.html { redirect_to @entity.project, notice: "#{@entity.type} was successfully updated." }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @entity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entities/1
  # DELETE /entities/1.json
  def destroy
    @entity = Entity.find(params[:id])
    @entity.destroy

    respond_to do |format|
      format.html { redirect_to project_url(@entity.project) }
      format.json { head :ok }
    end
  end
end
