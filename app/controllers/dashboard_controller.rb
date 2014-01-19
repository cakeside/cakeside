class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
    @creations = current_user.creations
    @activities = current_user.recent_activities
  end
end
