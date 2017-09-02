require_relative "../web_page.rb"

class DashboardPage < WebPage
  def initialize
    super(my_dashboard_path)
  end

  def logout
    click_link(I18n.t("logout"))
  end
end
