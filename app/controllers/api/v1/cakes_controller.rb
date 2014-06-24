module Api
  module V1
    class CakesController < ApiController
      respond_to :json

      def index
        respond_with(@cakes = current_user.creations)
      end

      def show
        respond_with(@cake = current_user.creations.find(params[:id]))
      end

      def create
        CreateCakeCommand.new(self).run(cake_params, params[:cake][:cake_tags])
      end

      def create_cake_succeeded(cake)
        respond_with(@cake = cake)
      end

      def create_cake_failed(cake)
        respond_with(@cake = cake)
      end

      def update
        raise params.inspect
      end

      private

      def cake_params
        params.require(:cake).permit(:name, :story, :is_restricted, :watermark, :category_id)
      end
    end
  end
end
