module Api
  module V1
    class ProfilesController < ApiController
      def show
        @profile = current_user
      end

      def update
        @profile = current_user
        unless @profile.update(secure_params)
          render json: @profile.errors, status: :unprocessable_entity
        end
      end

      private

      def secure_params
        params.require(:profile).permit(:name, :email, :city, :website, :twitter, :facebook)
      end
    end
  end
end
