module Admin
  class ToolsController < AdminController
    def index
      @tools = search_for_tools(params[:q])
    end

    private

    def search_for_tools(query)
      return [] if query.blank?
      client = ASIN::Client.instance
      client.search(Keywords: query, SearchIndex: :Kitchen, Sort: :salesrank)
    end
  end
end
