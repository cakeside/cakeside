class ProductsController < ApplicationController
  def initialize(product_api = Spank::IOC.resolve(:product_api))
    @product_api = product_api
    super()
  end

  def index
    @products = @product_api.search(params[:q])
    if @products.count == 1
      redirect_to product_path(@products.first.asin)
    end
  end

  def show
    @product = @product_api.find(params[:id])
  end
end
