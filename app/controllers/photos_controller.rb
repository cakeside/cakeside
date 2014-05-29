class PhotosController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :find_creation, :except => [:index, :show]

  def index
    @creation = Creation.find(params[:creation_id])
    @photos = @creation.photos
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: { files: @photos.map { |photo| PhotoToJQJsonMapper.new.map_from(photo) } } }
    end
  end

  def show
    @creation = Creation.find(params[:creation_id])
    @photo = @creation.photos.find(params[:id])
  end

  def new
    @photo = Photo.new
  end

  def create
    attributes = photo_params
    if params[:photo][:image].class == Array
      attributes[:image] = params[:photo][:image].first
    end

    @photo = @creation.photos.build(attributes)
    if @photo.save
      respond_to do |format|
        format.html { render :json => {files: [PhotoToJQJsonMapper.new.map_from(@photo)]}.to_json, :content_type => 'text/html', :layout => false }
        format.json { render :json => {files: [PhotoToJQJsonMapper.new.map_from(@photo)]}.to_json }
      end
    else
      render :json => [{:error => "oops... we're sorry but we weren't able to upload your photo."}], :status => 304
    end
  end

  def destroy
    @photo = @creation.photos.find(params[:id])
    if @photo.destroy
      @creation.touch
      render :json => {files: [PhotoToJQJsonMapper.new.map_from(@photo)]}.to_json
    else
      render :json => [{:error => "could not remove the photo"}], :status => 304
    end
  end

  private

  def find_creation
    @creation = current_user.creations.find(params[:creation_id])
    raise ActiveRecord::RecordNotFound unless @creation
  end

  def photo_params
    params.require(:photo).permit(:image)
  end

  class PhotoToJQJsonMapper
    def map_from(photo)
      {
        :name => photo.read_attribute(:image),
        :url => photo.image.url,
        :thumbnail_url => photo.is_processed? ? photo.image.thumb.url : photo.image.thumb.default_url,
        :delete_url => photo.id,
        :delete_type => "DELETE"
      }
    end
  end
end
