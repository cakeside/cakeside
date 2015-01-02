module Api
  module V1
    class PhotosController < ApiController
      def index
        @photos = current_user.creations.find(params[:cake_id]).photos
      end

      def show
        @photo = current_user.creations.find(params[:cake_id]).photos.find(params[:id])
      end

      def create
        @photo = UploadPhoto.new.run(params[:cake_id], params)
      end
    end
  end
end
