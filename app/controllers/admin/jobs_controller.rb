module Admin
  class JobsController < AdminController
    def index
      @jobs = Delayed::Job.order(:created_at => :desc)
    end
  end
end
