module Api
  module V1
    class TutorialsController < ApiController
      def index
        @tutorials = current_user.tutorials.page(page).per(per_page)
      end

      def create
        @tutorial = current_user.tutorials.create!(tutorial_params)
        current_user.tag(@tutorial, with: params[:tutorial][:tags], on: :tags)
      end

      private

      def tutorial_params
        params.require(:tutorial).permit(:url, :image_url, :heading, :description)
      end
    end
  end
end
