class PhotosController < ApplicationController
  before_filter :authenticate_user!

  def index
    @creation = Creation.find(params[:creation_id])
    @photos = @creation.photos
  end

  def show
    @creation = Creation.find(params[:creation_id])
    @photo = @creation.photos.find(params[:id])
  end
end
