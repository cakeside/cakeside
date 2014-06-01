module Admin
  class PhotosController < AdminController
    def initialize(photo_repository = Photo)
      @photo_repository = photo_repository
      super()
    end

    def index
      @photos = @photo_repository.order(id: :desc)
    end

    def show
      @photo = @photo_repository.find(params[:id])
      @results = Geocoder.search("#{@photo.latitude},#{@photo.longitude}")
    end
  end
end
