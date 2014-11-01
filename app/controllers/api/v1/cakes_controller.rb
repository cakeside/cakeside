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
        @cake = current_user.creations.find(params[:id])
        current_user.tag(@cake, with: params[:cake][:tags], on: :tags)
        current_user.tag(@cake, with: params[:cake][:tools], on: :tools)
        if @cake.update(cake_params.reject { |key, value| key == "tags" || key == "tools" })
          respond_with @cake
        else
          respond_with @cake
        end
      end

      def destroy
        @cake = current_user.creations.find(params[:id])
        @cake.destroy!
        respond_with(@cake)
      end

      private

      def cake_params
        params.require(:cake).permit(:name, :story, :category_id, :tags)
      end
    end
  end
end
