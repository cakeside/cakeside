module Admin
  class SessionsController < AdminController
    def index
      @sessions = UserSession.active
    end
  end
end
