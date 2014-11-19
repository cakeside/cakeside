module Api
  module V2
    class CakesController < ApplicationController
      def index
        @cakes = Creation.page(page).per(per_page)
      end

      def show(id = params[:id])
        @cake = Creation.find(id)
      end
    end
  end
end
