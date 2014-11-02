module My
  class DashboardController < BaseController
    def index
      @cakes = current_user.creations.includes(:photos)
      @tutorials = current_user.tutorials.limit(10)
      @activities = current_user.recent_activities
    end
  end
end
