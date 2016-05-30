class CartsController < ApplicationController
  before_action :set_session

  include CartsHelper
  include OrdersHelper

  def new
    @product = Product.find(params[:product_id])

    if params[:quantity].to_i > @product.inventory_quantity
      flash[:errors] = ["Sorry. We don't have that item in stock for the quantity specified."]
      render partial: "layouts/notices"
    else
      if request.xhr?
        add_product_to_cart
        @checkout = get_prods_and_qty
        @total_cost = get_order_total
        render 'carts/show', layout: false
      else
        if params[:quantity].to_i > @product.inventory_quantity
          flash[:errors] = ["Sorry. We don't have that item in stock for the quantity specified."]
          redirect_to product_path(@product)
        else
          add_product_to_cart
          redirect_to my_cart_path
        end
      end
    end
  end

  def show
    if params[:prod_id]
      cart.delete(params[:prod_id])
    end

    @checkout = get_prods_and_qty
    @total_cost = get_order_total
  end

  private
    def set_session
      cart_session
    end
end
