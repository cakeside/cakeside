module Api
  module V2
    class CategoriesController < ApplicationController
      def show(id = params[:id])
        @category = @categories.find(id)
      end
    end
  end
end
