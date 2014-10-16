module Admin
  class UsersController < AdminController
    def initialize(users_repository = Spank::IOC.resolve(:users))
      @users_repository = users_repository
      super()
    end

    def index
      @users = users_repository.search_by(params[:q])
    end

    def show
      @user = users_repository.includes(creations: :photos).find(params[:id])
    end

    private

    attr_reader :users_repository
  end
end
