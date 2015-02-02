require_relative "../web_page.rb"

class PasswordResetPage < WebPage
  def initialize(reset_password_token)
    super(edit_password_path(reset_password_token))
  end

  def change_password_to(new_password)
    fill_in "user_password", with: new_password
    click_button "Change my password"
  end
end
