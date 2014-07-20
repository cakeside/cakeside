module Api
  module V1
    class TutorialsController < ApiController
      respond_to :json

      def index
        respond_with(@tutorials = current_user.tutorials)
      end

      def create
        respond_with(@tutorial = current_user.tutorials.create!(tutorial_params))
      end

      private

      def tutorial_params
        params.require(:tutorial).permit(:url, :image_url, :heading, :description)
      end
    end
  end
end
