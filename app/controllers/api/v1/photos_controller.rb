module Api
  module V1
    class PhotosController < ApiController
      respond_to :json

      def index
        respond_with(@photos = current_user.creations.find(params[:cake_id]).photos)
      end

      def show
        respond_with(@photo = current_user.creations.find(params[:cake_id]).photos.find(params[:id]))
      end

      def create
        cake_id = params[:cake_id]
        UploadPhoto.new.run(cake_id, params)
        @photo = Creation.find(cake_id).photos.last
        respond_with(@photo)
      end

      private

      def photo_params
        params.require(:photo).permit(:image, :watermark)
      end
    end
  end
end
