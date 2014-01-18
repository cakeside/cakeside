class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
    @activities = current_user.recent_activities
  end
end
