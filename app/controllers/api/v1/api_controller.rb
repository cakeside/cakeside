module Api
  module V1
    class ApiController < ApplicationController
      before_action :restrict_access
      attr_reader :current_user

      private

      def restrict_access
        authenticate_or_request_with_http_token do |token, options|
          @current_user = User.find_by(authentication_token: token)
        end
      end
    end
  end
end
