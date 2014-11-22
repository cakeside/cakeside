module Api
  module V2
    class PhotosController < ApplicationController
      def index
        @photos = Photo.page(page).per(per_page)
      end

      def show(id = params[:id])
        @photo = Photo.find(id)
      end
    end
  end
end
