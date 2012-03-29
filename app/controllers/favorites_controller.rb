class FavoritesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_creation

  # GET /favorites
  def index
    @favorites = @creation.favorites
  end

  # POST /favorites
  def create
    if( current_user.owns @creation )
      redirect_to @creation, :notice => "You can't favorite your own stuff"
      return
    end
    @favorite = current_user.add_favorite(@creation)
    if @favorite.save
       redirect_to @creation, :notice => 'Welcome to the fanclub!'
    else
       redirect_to @creation
    end
  end

  private
  def find_creation
    @creation = Creation.find(params[:creation_id])
    raise ActiveRecord::RecordNotFound unless @creation
  end
end
