module Admin
  class ProductsController < AdminController
    def initialize(product_api = Spank::IOC.resolve(:product_api))
      @product_api = product_api
      super()
    end

    def index
      @products = @product_api.search(params[:q])
    end

    def show
      @product = @product_api.find(params[:id])
    end

    def create
      Tool.create(:name=>params[:name],:asin=>params[:asin])
      redirect_to admin_products_path(params[:asin])
    end
  end
end
