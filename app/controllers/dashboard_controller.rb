class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
    @creations = current_user.creations
    @tutorials = current_user.tutorials
    @activities = current_user.recent_activities
  end
end
