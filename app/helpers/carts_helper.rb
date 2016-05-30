module CartsHelper
  def cart_session
    # Assigns a cart session if there's a new user
    unless session[:products]
      session[:products] = {}
    end
  end

  def add_product_to_cart
    cart[params[:product_id]] = params[:quantity].to_i
  end

  def cart
    session[:products]
  end
end
