require_relative "../web_page.rb"

class LoginPage < WebPage
  def initialize
    super(new_session_path)
  end

  def login_with(email:, password: "password")
    within("#new_user_session") do
      fill_in("session_email", with: email)
      fill_in("session_password", with: password)
    end
    click_button(I18n.t('sessions.new.sign_in'))
  end
end
