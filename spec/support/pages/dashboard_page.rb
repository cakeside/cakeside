require_relative "../web_page.rb"

class DashboardPage < WebPage
  def initialize
    super(my_dashboard_path)
  end

  def logout
    click_link("Sign Out")
  end
end
