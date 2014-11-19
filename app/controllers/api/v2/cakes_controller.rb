module Api
  module V2
    class CakesController < ApplicationController
      def index
        @cakes = Creation.all
      end

      def show(id = params[:id])
        @cake = Creation.find(id)
      end
    end
  end
end
