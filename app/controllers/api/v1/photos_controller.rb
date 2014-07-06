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
        respond_with(@photo = UploadPhoto.new.run(params[:cake_id], params))
      end
    end
  end
end
