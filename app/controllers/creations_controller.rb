class CreationsController < ApplicationController
  def index
    @creations = FindAllCreationsQuery.new.fetch(params)
  end

  def show
    @creation = FindCreationQuery.new.fetch(params[:id])
    if params[:photo_id].present?
      @primary_image = @creation.photos.find(params[:photo_id])
    else
      @primary_image = @creation.primary_image
    end
  end
end
