module My
  module DashboardHelper
    def unique_tags
      Tag.unique_tags
    end

    def unique_tools
      Tag.unique_tools
    end
  end
end
