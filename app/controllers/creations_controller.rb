class CreationsController < ApplicationController
  def index
    @creations = FindAllCreationsQuery.new.fetch(params)
  end

  def show
    @creation = Creation.find(params[:id])
    @primary_image = params[:photo_id].present? ?  @creation.photos.find(params[:photo_id]) : @creation.primary_image
  end
end
