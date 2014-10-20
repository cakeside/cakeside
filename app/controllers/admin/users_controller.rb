module Admin
  class UsersController < AdminController
    def initialize(repository = Spank::IOC.resolve(:users))
      @repository = repository
      super()
    end

    def index
      @users = repository.search_with(params)
    end

    def show
      @user = repository.includes(creations: :photos).find(params[:id])
    end

    private

    attr_reader :repository
  end
end
