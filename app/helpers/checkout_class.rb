class Checkout
  attr_accessor

  def initialize(prod_and_qtys)
    @products = get_products(prod_and_qtys)
  end

  def get_products(prod_and_qtys)
    prod_and_qtys.each do |prod_and_qty|

    end
  end

end
