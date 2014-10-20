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

    def update
      @user = User.find(params[:id])
      @user.update(secure_params)
      redirect_to :back
    end

    private

    def secure_params
      params.require(:user).permit(:name, :email, :city, :website, :twitter, :facebook)
    end

    attr_reader :repository
  end
end
