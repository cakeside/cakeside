module Api
  module V2
    class CakesController < ApplicationController
      def initialize(repository = Spank::IOC.resolve(:cakes))
        @repository = repository
        super()
      end

      def index
        @cakes = paginate(@repository.search_with(params).includes(:category))
      end

      def show(id = params[:id])
        @cake = @repository.find(id)
      end
    end
  end
end
