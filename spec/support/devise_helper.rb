module DeviseHelper
  module Controllers
    def http_login(user)
      new_session = UserSession.new
      controller.stub(:authenticate!).and_return(new_session)
      controller.stub(:current_user).and_return(user)
    end
  end
end
