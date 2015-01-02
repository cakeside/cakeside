module Authentication
  def http_login(user)
    new_session = UserSession.new
    allow(controller).to receive(:user_session).and_return(new_session)
    allow(controller).to receive(:current_user).and_return(user)
    allow(controller).to receive(:user_signed_in?).and_return(true)
  end
end
