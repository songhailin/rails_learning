class StoreController < ApplicationController
  def index
    @products = Product.find_products_by_sale
  end

  
end
