module Api
  module V1
    class CreationsController < ApplicationController
      before_filter :restrict_access
      respond_to :json

      def index
        @creations = Creation.visible_creations
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
