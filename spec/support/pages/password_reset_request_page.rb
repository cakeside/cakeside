require_relative "../web_page.rb"

class PasswordResetRequestPage < WebPage
  def initialize
    super(new_password_path)
  end

  def reset_password(email)
    within "#new_user" do
      fill_in "user_email", with: email
    end
    click_button "Send me reset password instructions"
  end
end
