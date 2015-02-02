require_relative '../web_page.rb'

class LoginPage < WebPage
  def initialize
    super(new_session_path)
  end

  def login_with(email:, password: 'password')
    within('.form-inline') do
      fill_in('session_username', with: email)
      fill_in('session_password', with: password)
    end
    click_button("Sign In")
  end
end
