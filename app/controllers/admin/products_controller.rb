module Admin
  class ProductsController < AdminController
    def initialize(product_api = Spank::IOC.resolve(:product_api))
      @product_api = product_api
      super()
    end

    def index
      @products = @product_api.search(params[:q])
    end
  end
end
