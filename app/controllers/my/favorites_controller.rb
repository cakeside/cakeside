module My
  class FavoritesController < BaseController
    def index
      @creations = current_user.favorite_cakes
    end
  end
end
