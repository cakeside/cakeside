class FavoritesController < ApplicationController
  before_action :authenticate!

  def create
    cake = Creation.find(params[:cake_id])
    current_user.add_favorite(cake)

    redirect_to cake_path(cake), notice: "This has been added to your favorites"
  end
end
