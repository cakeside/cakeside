module Admin
  class ToolsController < AdminController
    def initialize(product_api = Spank::IOC.resolve(:product_api))
      @product_api = product_api
      super()
    end

    def index
      @tools = @product_api.search(params[:q])
    end
  end
end
