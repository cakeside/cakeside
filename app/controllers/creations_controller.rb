class CreationsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]

  def index
    @creations = FindAllCreationsQuery.new.fetch(params)
  end

  def show
    @creation = Creation.find(params[:id])
    @primary_photo = @creation.primary_image
    @comments = @creation.comment_threads.includes(:user)
  end

  def new
    @creation = Creation.new
    @user = current_user
  end

  def edit
    @creation = current_user.creations.find(params[:id])
  end

  def create
    @creation = current_user.creations.create(params[:creation])
    @creation.categories << Category.find(params[:category_id]) if params[:category_id]
    current_user.tag(@creation, :with => params[:creation_tags], :on => :tags)

    if @creation.save
      redirect_to new_creation_photo_url(@creation)
    else
      @user = current_user
      flash[:error] = @creation.errors.full_messages
      render :action => "new" 
    end
  end

  def update
    @creation = current_user.creations.find(params[:id])
    @creation.categories.clear
    @creation.categories << Category.find(params[:category_id]) if params[:category_id]
    current_user.tag(@creation, :with => params[:creation_tags], :on => :tags)

    if @creation.update_attributes(params[:creation])
      redirect_to new_creation_photo_url(@creation)
    else
      flash[:error] = @creation.errors.full_messages
      render :action => "edit" 
    end
  end

  def destroy
    current_user.creations.find(params[:id]).destroy
    redirect_to(creations_url) 
  end

  def mine
    @creations = current_user.creations.page(params[:page]).per(12)
  end
end
