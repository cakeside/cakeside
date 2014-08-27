module Api
  module V1
    class TutorialsController < ApiController
      respond_to :json

      def index
        respond_with(@tutorials = current_user.tutorials)
      end

      def create
        @tutorial = current_user.tutorials.create!(tutorial_params)
        current_user.tag(@tutorial, with: params[:tutorial][:tags], on: :tags)
        respond_with(@tutorial)
      end

      private

      def tutorial_params
        params.require(:tutorial).permit(:url, :image_url, :heading, :description)
      end
    end
  end
end
