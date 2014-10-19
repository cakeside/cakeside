class CakesController < ApplicationController
  def index
    @creations = AllCakesQuery.new.fetch(params).page(page).per(per_page)
  end

  def show
    @creation = Creation.find(params[:id])
    @primary_image = params[:photo_id].present? ?  @creation.photos.find(params[:photo_id]) : @creation.primary_image
  end
end
