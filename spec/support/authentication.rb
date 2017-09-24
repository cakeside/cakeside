module Authentication
  def http_login(user)
    new_session = UserSession.new
    allow(controller).to receive(:user_session).and_return(new_session)
    allow(controller).to receive(:current_user).and_return(user)
    allow(controller).to receive(:current_user?).and_return(true)
  end

  def api_login(user)
    encoded_credentials = ActionController::HttpAuthentication::Token.
      encode_credentials(user.authentication_token)
    request.env["HTTP_AUTHORIZATION"] = encoded_credentials
  end

  module Capybara
    def http_login(user)
      LoginPage.new.visit_page.login_with(email: user.email, password: "password")
    end
  end
end
