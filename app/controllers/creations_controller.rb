class CreationsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]
  # GET /creations
  def index
    @creations = Creation.where(:is_restricted => false, :is_published => true).page(params[:page]).per(16)
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
    @creation.photos.build({:is_primary => true, :image => params[:creation][:image]})

    if @creation.save
      redirect_to(creations_url, :notice => 'Thank you for sharing your creation. It will appear in the main timeline shortly.') 
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
end
