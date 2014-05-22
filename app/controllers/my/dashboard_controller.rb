module My
  class DashboardController < BaseController
    def index
      @items = (current_user.creations + current_user.tutorials).sort_by! { |x| x.created_at }.reverse
      @activities = current_user.recent_activities
    end
  end
end
