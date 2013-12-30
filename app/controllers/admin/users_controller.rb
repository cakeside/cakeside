module Admin
  class UsersController < ApplicationController
    before_filter :restrict_access!

    def index
    end

    private

    def restrict_access!
      redirect_to root_path unless current_user.is_admin?
    end
  end
end
