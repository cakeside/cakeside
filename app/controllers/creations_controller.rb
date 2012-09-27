class CreationsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]
  # GET /creations
  def index
    @creations = Creation.where(:is_restricted => false).page(params[:page]).per(16)
  end

  # GET /creations/1
  def show
    @creation = Creation.find(params[:id])
    @profile = @creation.user
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
    if @creation.save
      #redirect_to( '/creations/crop/' + @creation.id.to_s ) 
      redirect_to(@creation, :notice => 'Creation was successfully cropped.') 
    else
      flash[:error] = @creation.errors.full_messages
      render :action => "new" 
    end
  end

  # PUT /creations/1
  def update
    @creation = current_user.creations.find(params[:id])
    @creation.category_ids = params[:creation][:category_ids] ||= []

    if @creation.update_attributes(params[:creation])
      redirect_to(@creation, :notice => 'Creation was successfully updated.') 
    else
      render :action => "edit" 
    end
  end

  # DELETE /creations/1
  def destroy
    current_user.creations.find(params[:id]).destroy
    redirect_to(creations_url) 
  end

  # GET /creations/crop/1
  def crop
    @creation = current_user.creations.find(params[:id])
  end

  def crop_update
    @creation = current_user.creations.find(params[:id])
    @creation.crop_x = params[:creation]["crop_x"]
    @creation.crop_y = params[:creation]["crop_y"]
    @creation.crop_h = params[:creation]["crop_h"]
    @creation.crop_w = params[:creation]["crop_w"]
    @creation.reprocess_image
    if @creation.save
      redirect_to(@creation, :notice => 'Creation was successfully cropped.') 
    else
      render :action => "new" 
    end
  end
end
