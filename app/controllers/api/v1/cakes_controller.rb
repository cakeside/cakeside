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
        name = cake_params[:name]
        category = Category.find(cake_params[:category_id])
        @cake = current_user.create_cake(name: name, category: category)
        if @cake.save
          one_hour = 1.hour.from_now
          PublishToTwitterJob.set(wait_until: one_hour).perform_later(@cake)
        end
      end

      def update
        @cake = current_user.creations.find(params[:id])
        current_user.tag(@cake, with: params[:cake][:tags], on: :tags)
        @cake.update!(cake_params.reject { |key, _| key == "tags" })
      end

      def destroy
        @cake = current_user.creations.find(params[:id])
        @cake.destroy!
        render nothing: true
      end

      private

      def cake_params
        params.require(:cake).permit(:name, :story, :category_id, :tags)
      end
    end
  end
end
