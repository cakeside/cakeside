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
        cake = current_user.creations.find(params[:cake_id])
        @photo = UploadPhoto.new(cake).run(params)
      end
    end
  end
end
