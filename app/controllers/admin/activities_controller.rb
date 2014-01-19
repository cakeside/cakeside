module Admin
  class ActivitiesController < AdminController
    def index
      @recent_activities = Activity.order(:created_at => :desc).limit(100)
      expires_in(10.minutes)
    end
  end
end
