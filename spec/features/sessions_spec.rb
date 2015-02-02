require 'rails_helper'

class WebPage
  include Capybara::DSL
  include Rails.application.routes.url_helpers
  attr_reader :page_path

  def initialize(page_path)
    @page_path = page_path
  end

  def visit_page
    visit page_path
    self
  end

  def on_page?
    current_path == page_path
  end
end

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

describe "Logins" do
  describe "GET /login" do
    subject { LoginPage.new }

    before :each do
      subject.visit_page
    end

    context "when an email is registered", js: true do
      let!(:user) { create(:user, password: "password") }

      before :each do
        subject.login_with(email: user.email, password: "password")
      end

      it "logs the user in" do
        expect(page).to have_content("Log Out")
      end

      it "has no errors" do
        expect(page).to_not have_content(I18n.t('devise.failure.invalid'))
      end
    end

    context "when an email is not known", js: true do
      before :each do
        subject.login_with(email: 'test@example.com', password: 'password')
      end

      it "displays an error message" do
        expect(page).to have_content("invalid email or password.")
      end
    end
  end
end
