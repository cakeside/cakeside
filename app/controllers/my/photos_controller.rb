module My
  class PhotosController < BaseController
    before_filter :find_creation

    def initialize(mapper = PhotoToJQJsonMapper.new)
      @mapper = mapper
      super()
    end

    def index
      @photos = @cake.photos
      render json: { files: @photos.map { |photo| @mapper.map_from(photo) } }
    end

    def new
      @photo = Photo.new
    end

    def create
      render json: { files: [UploadPhoto.new.run(params[:cake_id], photo_params)] }
    end

    def destroy
      @photo = @cake.photos.find(params[:id])
      if @photo.destroy
        @cake.touch
        render json: { files: [@mapper.map_from(@photo)] }
      else
        render json: [ { error: "could not remove the photo" } ], status: 304
      end
    end

    private

    def find_creation
      @cake = current_user.creations.find(params[:cake_id])
      raise ActiveRecord::RecordNotFound unless @cake
    end

    def photo_params
      params.require(:photo).permit(:image)
    end
  end
end
