module Api
  module V2
    class CakesController < ApplicationController
      attr_reader :repository

      def initialize(repository = Spank::IOC.resolve(:cakes))
        @repository = repository
        super()
      end

      def index
        @cakes = paginate(repository.search_with(params).includes(:category))
        @photos = Photo.processed.where(imageable_id: @cakes.pluck(:id))
      end

      def show(id = params[:id])
        @cake = repository.find(id)
      end
    end
  end
end
