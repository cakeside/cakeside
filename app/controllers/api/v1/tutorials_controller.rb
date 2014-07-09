module Api
  module V1
    class TutorialsController < ApiController
      respond_to :json

      def index
        respond_with(@tutorials = current_user.tutorials)
      end
    end
  end
end
