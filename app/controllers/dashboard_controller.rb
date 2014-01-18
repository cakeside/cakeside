class DashboardController < ApplicationController
  def index
    @activities = current_user.recent_activities
  end
end
