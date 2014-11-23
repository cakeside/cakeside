module Api
  module V2
    class CakesController < ApplicationController
      def initialize(repository = Spank::IOC.resolve(:cakes))
        @repository = repository
        super()
      end

      def index
        @cakes = @repository.search_with(params).includes(:category).page(page).per(per_page)
      end

      def show(id = params[:id])
        @cake = @repository.find(id)
      end
    end
  end
end
