class CreationsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]
  # GET /creations
  def index
    @creations = Creation.page(params[:page]).per(16)
  end

  # GET /creations/1
  def show
    @creation = Creation.find(params[:id])
    @profile = @creation.user
    @creations = @creation.user.creations.page(params[:page]).per(9)
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
        flash[:error] = @creation.errors.full_messages
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
    respond_to do |format|
      if @creation.save
        format.html { redirect_to(@creation, :notice => 'Creation was successfully cropped.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

end
