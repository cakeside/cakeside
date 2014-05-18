module Admin
  class PhotosController < AdminController
    def index
      @photos = Photo.order(id: :desc)
    end

    def show
      @photo = Photo.find(params[:id])
    end
  end
end
