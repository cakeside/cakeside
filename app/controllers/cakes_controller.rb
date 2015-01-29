class CakesController < ApplicationController
  def initialize(repository = Spank::IOC.resolve(:cakes))
    @repository = repository
    super()
  end

  def index
    @cakes = @repository.search_with(params).page(page).per(per_page)
  end

  def show
    @creation = Creation.find(params[:id])
    @primary_image = params[:photo_id].present? ?  @creation.photos.find(params[:photo_id]) : @creation.primary_image
  end
end
