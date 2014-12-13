module Admin
  class ProductsController < AdminController
    attr_reader :product_api

    def initialize(product_api = Spank::IOC.resolve(:product_api))
      @product_api = product_api
      super()
    end

    def index
      @products = @product_api.search(params[:q])
    end

    def show
      @product = product_api.find(params[:id])
      @tool = Tool.find_by(:asin=>params[:id])
    end

    def create
      Tool.create(:name=>params[:name],:asin=>params[:asin])
      redirect_to admin_product_path(params[:asin])
    end
  end
end
