module My
  class CakesController < BaseController
    def index
      @creations = current_user.creations.includes([:user]).page(params[:page]).per(12)
    end
  end
end
