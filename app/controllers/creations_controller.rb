class CreationsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]

  def index
    @creations = FindAllCreationsQuery.new.fetch(params)
    expires_in(10.minutes) unless user_signed_in?
  end

  def show
    @creation = FindCreationQuery.new.fetch(params[:id])
    expires_in(1.minute) unless user_signed_in?
  end

  def new
    @creation = Creation.new
    @user = current_user
  end

  def edit
    @creation = current_user.creations.find(params[:id])
  end

  def create
    CreateCakeCommand.new(self).run(creation_params, params[:creation_tags])
  end

  def create_cake_succeeded(cake)
    @creation = cake
    redirect_to new_my_cake_photo_path(cake)
  end

  def create_cake_failed(cake)
    @creation = cake
    flash[:error] = @creation.errors.full_messages
    render :new
  end

  def update
    UpdateCakeCommand.new(self).run(params[:id], params[:creation_tags], creation_params)
  end

  def update_cake_succeeded(cake)
    @creation = cake
    redirect_to new_my_cake_photo_path(@creation)
  end

  def update_cake_failed(cake)
    @creation = cake
    flash[:error] = @creation.errors.full_messages
    render :edit
  end

  def destroy
    RemoveCakeCommand.new(self).run(params[:id])
    redirect_to my_dashboard_path
  end

  private

  def creation_params
    params.require(:creation).permit(:name, :story, :category_id)
  end
end
