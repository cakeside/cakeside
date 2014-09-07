class FavoritesController < ApplicationController
  before_action :authenticate!

  def index
    @creation = FindCreationQuery.new.fetch(params[:creation_id])
    @favorites = @creation.favorites
  end

  def create
    AddToFavorites.new(self).run(params[:creation_id])
  end

  def favorite_created(cake, message)
    redirect_to cake, notice: message
  end

  def create_favorite_failed(cake)
    redirect_to cake
  end
end
