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
        CreateCakeCommand.new(self).run(cake_params, params[:cake][:tags])
      end

      def create_cake_succeeded(cake)
        respond_with(@cake = cake)
      end

      def create_cake_failed(cake)
        respond_with(@cake = cake)
      end

      def update
        UpdateCakeCommand.new(self).run(params[:id], params[:cake][:tags], cake_params)
      end

      def update_cake_succeeded(cake)
        respond_with(@cake = cake)
      end

      def update_cake_failed(cake)
        respond_with(@cake = cake)
      end

      private

      def cake_params
        params.require(:cake).permit(:name, :story, :is_restricted, :watermark, :category_id, :tags)
      end
    end
  end
end
