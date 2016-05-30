class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :set_session
  before_action :round_price, only: [:create, :update]
  before_action :require_admin, only: [:new, :create, :edit, :update, :destroy]

  include CartsHelper
  include UsersHelper

  def index
    @products = Product.all.reverse
  end

  def show
  end

  def new
    @product = Product.new
  end

  def edit
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      flash[:success] = 'Product was successfully created.'
      redirect_to @product
    else
      flash[:errors] = @product.errors.full_messages
      render :new
    end
  end

  def update
    if @product.update(product_params)
      flash[:success] = 'Product was successfully updated.'
      redirect_to @product
    else
      flash[:errors] = @product.errors.full_messages
      render :edit
    end
  end

  def destroy
    @product.destroy
    flash[:success] = 'Product was successfully destroyed.'
    redirect_to products_url
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :image_url, :description, :inventory_quantity, :price)
    end

    def set_session
      cart_session
    end

    def round_price
      params[:product][:price] = params[:product][:price].to_f.round(2)
    end

    def require_admin
      is_admin?
    end
end
