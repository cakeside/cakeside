module Admin
  class JobsController < AdminController
    def initialize(repository = Delayed::Job)
      @repository = repository
      super()
    end

    def index
      @jobs = @repository.order(created_at: :desc)
    end

    def show
      @job = @repository.find(params[:id])
    end

    def update
      @job = @repository.find(params[:id])
      @job.invoke_job
      redirect_to admin_jobs_path
    end

    def destroy
      @job = @repository.find(params[:id])
      @job.destroy
      redirect_to admin_jobs_path
    end
  end
end
