class PhotosController < ApplicationController
  def index
    @creation = Creation.find(params[:cake_id])
    @photos = @creation.photos
  end

  def show
    @creation = Creation.find(params[:cake_id])
    @photo = @creation.photos.find(params[:id])
  end
end
