class PhotosController < ApplicationController
  before_filter :authenticate_user!, :except => [:index]
  before_filter :find_creation, :except => [:index]

  def index
    @creation = Creation.find(params[:creation_id])
    @photos = @creation.photos
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: {files: @photos.map { |p| p.to_jq_upload } }.to_json }
    end
  end

  def new
    @photo = Photo.new
  end

  def create
    attributes = photo_params
    attributes[:image] = params[:photo][:image].first if params[:photo][:image].class == Array

    @photo = @creation.photos.build(attributes)
    if @photo.save
      respond_to do |format|
        format.html { render :json => {files: [@photo.to_jq_upload]}.to_json, :content_type => 'text/html', :layout => false }
        format.json { render :json => {files: [@photo.to_jq_upload]}.to_json }
      end
    else
      render :json => [{:error => "oops... we're sorry but we weren't able to upload your photo."}], :status => 304
    end
  end

  def destroy
    @photo = @creation.photos.find(params[:id])
    if @photo.destroy
      render :json => {files: [@photo.to_jq_upload]}.to_json
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
end
