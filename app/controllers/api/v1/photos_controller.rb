module Api
  module V1
    class PhotosController < ApiController
      respond_to :json

      def create
        cake_id = params[:cake_id]
        UploadPhoto.new.run(cake_id, photo_params)
        @photo = Creation.find(cake_id).photos.last
        respond_with(@photo)
      end

      private

      def photo_params
        params.require(:photo).permit(:image)
      end
    end
  end
end
