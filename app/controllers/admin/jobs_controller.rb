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
  end
end
