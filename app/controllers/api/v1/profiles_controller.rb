module Api
  module V1
    class ProfilesController < ApiController
      def show
        @profile = current_user
      end

      def update
        @profile = current_user
        @profile.update(secure_params)
      end

      private

      def secure_params
        params.require(:profile).permit(:name, :email, :city, :website, :twitter, :facebook)
      end
    end
  end
end
