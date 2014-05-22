module My
  class FavoritesController < BaseController
    def index
      @user = current_user
      @favorites = current_user.favorites.includes(:creation)
      @creations = @favorites.map {|f| f.creation }
    end
  end
end
