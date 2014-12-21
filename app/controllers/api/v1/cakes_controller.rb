module Api
  module V1
    class CakesController < ApiController
      def index
        @cakes = current_user.creations
      end

      def show
        @cake = current_user.creations.find(params[:id])
      end

      def create
        CreateCakeCommand.new(self).run(cake_params, params[:cake][:tags])
      end

      def create_cake_succeeded(cake)
        @cake = cake
      end

      def create_cake_failed(cake)
        @cake = cake
      end

      def update
        @cake = current_user.creations.find(params[:id])
        current_user.tag(@cake, with: params[:cake][:tags], on: :tags)
        if @cake.update(cake_params.reject { |key, value| key == "tags" })
          @cake
        else
          @cake
        end
      end

      def destroy
        @cake = current_user.creations.find(params[:id])
        @cake.destroy!
      end

      private

      def cake_params
        params.require(:cake).permit(:name, :story, :category_id, :tags)
      end
    end
  end
end
