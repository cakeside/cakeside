class CreationsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]
  # GET /creations
  def index
    @creations = Creation.where(:is_restricted => false, :is_published => true).page(params[:page]).per(16)
  end

  # GET /creations/1
  def show
    @creation = Creation.find(params[:id])
    @primary_photo = @creation.photos.first
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
      redirect_to new_creation_photo_url(@creation)
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
      redirect_to new_creation_photo_url(@creation)
    else
      flash[:error] = @creation.errors.full_messages
      render :action => "edit" 
    end
  end

  # DELETE /creations/1
  def destroy
    current_user.creations.find(params[:id]).destroy
    redirect_to(creations_url) 
  end
end
