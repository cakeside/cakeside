class CreationsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]

  def index
    @creations = FindAllCreationsQuery.new.fetch(params)
    expires_in(10.minutes)
    fresh_when(Creation.maximum(:updated_at)) if Creation.any?
  end

  def show
    @creation = Creation.find(params[:id])
    @primary_photo = @creation.primary_image
    expires_in(1.minute)
    #fresh_when(@creation)
  end

  def new
    @creation = Creation.new
    @user = current_user
  end

  def edit
    @creation = current_user.creations.find(params[:id])
  end

  def create
    @creation = current_user.creations.create(creation_params)
    @creation.categories << Category.find(params[:category_id]) if params[:category_id]
    current_user.tag(@creation, :with => params[:creation_tags], :on => :tags)

    if @creation.save
      redirect_to new_creation_photo_url(@creation)
    else
      flash[:error] = @creation.errors.full_messages
      render :new
    end
  end

  def update
    @creation = current_user.creations.find(params[:id])
    @creation.categories.clear
    @creation.categories << Category.find(params[:category_id]) if params[:category_id]
    current_user.tag(@creation, :with => params[:creation_tags], :on => :tags)

    if @creation.update_attributes(creation_params)
      redirect_to new_creation_photo_url(@creation)
    else
      flash[:error] = @creation.errors.full_messages
      render :edit
    end
  end

  def destroy
    current_user.creations.find(params[:id]).destroy
    redirect_to(creations_url) 
  end

  def mine
    @creations = current_user.creations.includes([:user]).page(params[:page]).per(12)
  end

  private

  def creation_params
    params.require(:creation).permit(:name, :story, :is_restricted, :watermark)
  end
end
