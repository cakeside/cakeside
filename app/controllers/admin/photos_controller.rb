module Admin
  class PhotosController < AdminController
    def initialize(photo_repository = Photo, storage = Spank::IOC.resolve(:blob_storage))
      @photo_repository = photo_repository
      @storage = storage
      super()
    end

    def index
      @photos = paginate(@photo_repository.order(id: :desc))
    end

    def show
      @photo = @photo_repository.find(params[:id])
    end

    def update
      ReProcessPhotoJob.perform_later(@photo_repository.find(params[:id]))
      redirect_to admin_photos_path
    end
  end
end
