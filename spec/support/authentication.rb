module Authentication
  def http_login(user)
    new_session = UserSession.new
    controller.stub(:user_session).and_return(new_session)
    controller.stub(:current_user).and_return(user)
    controller.stub(:user_signed_in?).and_return(true)
  end
end
