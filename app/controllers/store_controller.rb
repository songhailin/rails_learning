class StoreController < ApplicationController
  layout "store"
  def index
    @products = Product.find_products_by_sale
    @cart = find_cart
  end

  def add_to_cart
    product = Product.find(params[:id])
    @cart = find_cart
    @current_item = @cart.add_product(product)
    respond_to do |format|
      format.js
    end
  rescue ActiveRecord::RecordNotFound
    logger.error("Attempt to access invalid product #{params[:id]}")
    redirect_to_index("Invalid product")
  end

  def checkout
    @cart = find_cart
    if @cart.items.empty?
      redirect_to_index("Your cart is currently empty")
    end
    @order = Order.new
  end

  def empty_cart
    session[:cart] = nil
    redirect_to_index("Your cart is currently empty")
  end

  def redirect_to_index(msg=nil)
    flash[:notice] = msg if msg
    redirect_to :action=>'index'
  end

  private
  
  def find_cart
    unless session[:cart]
      session[:cart] = Cart.new
    end
    session[:cart]
  end
  
end
