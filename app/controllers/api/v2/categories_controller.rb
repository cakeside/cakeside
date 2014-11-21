module Api
  module V2
    class CategoriesController < ApplicationController
      def show
        @category = Category.find(params[:id])
      end
    end
  end
end
