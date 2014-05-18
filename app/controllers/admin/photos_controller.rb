module Admin
  class PhotosController < AdminController
    def index
      @photos = Photo.all
    end

    def show
      @photo = Photo.find(params[:id])
    end
  end
end
