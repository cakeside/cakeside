module Api
  module V2
    class TutorialsController < ApplicationController
      def index
        @tutorials = Tutorial.page(page).per(per_page)
      end
    end
  end
end
