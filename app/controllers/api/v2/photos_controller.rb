module Api
  module V2
    class PhotosController < ApplicationController
      def index
        @photos = paginate(Photo.processed)
      end

      def show(id = params[:id])
        @photo = Photo.find(id)
      end
    end
  end
end
