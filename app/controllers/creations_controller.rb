class CreationsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]
  # GET /creations
  def index
    @creations = Creation.page(params[:page]).per(8)
  end

  # GET /creations/1
  def show
    @creation = Creation.find(params[:id])
    @profile = @creation.user
    @creations = @creation.user.creations.page(params[:page]).per(8)
  end

  # GET /creations/new
  def new
    @creation = Creation.new
  end

  # GET /creations/1/edit
  def edit
    @creation = current_user.creations.find(params[:id])
  end

  # POST /creations
  def create
    @creation = current_user.creations.create(params[:creation])
    @creation.category_ids = params[:creation][:category_ids] ||= []
    respond_to do |format|
      if @creation.save
        if params[:creation][:image].blank? 
          format.html { redirect_to(@creation, :notice => 'Creation was successfully created.') }
        else
          format.html { render :action => "crop" }
        end
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /creations/1
  def update
    @creation = current_user.creations.find(params[:id])
    @creation.category_ids = params[:creation][:category_ids] ||= []

    respond_to do |format|
      if @creation.update_attributes(params[:creation])
        format.html { redirect_to(@creation, :notice => 'Creation was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /creations/1
  def destroy
    @creation = current_user.creations.find(params[:id])
    @creation.destroy

    respond_to do |format|
      format.html { redirect_to(creations_url) }
    end
  end

  def crop
    
  end

end
