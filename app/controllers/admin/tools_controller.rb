module Admin
  class ToolsController < AdminController
    def index
      @tools = AmazonAPI.new.search(params[:q])
    end
  end
end
