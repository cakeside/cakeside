module Api
  module V2
    class CakesController < ApplicationController
      def index
        @cakes = Creation.all
      end
    end
  end
end
