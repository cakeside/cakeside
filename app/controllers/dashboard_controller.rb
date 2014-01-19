class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
    @items = (current_user.creations + current_user.tutorials).sort_by! { |x| x.created_at }.reverse
    @activities = current_user.recent_activities
  end
end
