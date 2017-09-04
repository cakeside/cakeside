require "rails_helper"

describe "changing my password", js: true do
  context "when changing my password" do
    let(:user) { create(:user, password: "password") }

    before { http_login(user) }

    it "displays a confirmation message" do
      visit my_dashboard_path
      click_link(I18n.t("my.shared.my_nav.change_password"))

      within(".form-horizontal") do
        fill_in("user_old_password", with: "password")
        fill_in("user_password", with: "secret")
        fill_in("user_password_confirmation", with: "secret")
      end
      click_button "Update password"
      expect(page).to have_content(I18n.translate("my.passwords.updated"))
    end
  end
end
