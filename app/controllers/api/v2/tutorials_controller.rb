module Api
  module V2
    class TutorialsController < ApplicationController
      def index
        @tutorials = Tutorial.page(page).per(per_page)
      end

      def show(id = params[:id])
        @tutorial = Tutorial.find(id)
      end
    end
  end
end
