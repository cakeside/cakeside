module My
  class CakesController < BaseController
    def index
      @cakes = current_user.creations.includes(:photos)
    end
  end
end
