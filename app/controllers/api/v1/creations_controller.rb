module Api
  module V1
    class CreationsController < ApplicationController
      before_filter :restrict_access
      respond_to :json

      def index
        @creations = Creation.includes(:user, :photos).where(:is_restricted => false).where('photos_count > 0').uniq
      end

      private

      def restrict_access
        authenticate_or_request_with_http_token do |token, options|
          User.exists?(:authentication_token => token)
        end
      end

    end
  end
end
