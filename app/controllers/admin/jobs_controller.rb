module Admin
  class JobsController < AdminController
    def index
      @jobs = Delayed::Job.order(:created_at => :desc)
    end

    def show
      @job = Delayed::Job.find(params[:id])
    end
  end
end
