class AdminsController < ApplicationController
  before_action :require_admin, only: [:index, :show]

  include UsersHelper

  def index
    @products = Product.all.reverse
  end

  def show
    @product = Product.find(params[:id])
  end

  private
    def require_admin
      is_admin?
    end

end
