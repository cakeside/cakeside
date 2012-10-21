class PhotosController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_creation
  before_filter :find_or_build_photo

  def new
    @photo = Photo.new
    @creation = Creation.find(params[:creation_id])
  end

  def create
    if @photo.save
      redirect_to new_creation_photo_url(@photo.creation, :notice => 'A new photo was added to the album.')
    else
      flash[:error] = "could not upload photo"
    end
  end

  def destroy
    if @photo.destroy
      redirect_to(@creation, :notice => 'A new photo was added to the album.') 
    else
      flash[:error] = "photo could not be deleted"
    end
  end

  private
  def find_creation
    @creation = current_user.creations.find(params[:creation_id])
    raise ActiveRecord::RecordNotFound unless @creation
  end

  def find_or_build_photo
    @photo = params[:id] ? @creation.photos.find(params[:id]) : @creation.photos.build(params[:photo])
  end
end
