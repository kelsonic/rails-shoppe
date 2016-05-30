module OrdersHelper

  def get_order_total
    total_cost_of_order(get_prods_and_qty)
  end

  def get_prods_and_qty
    merge_prods_with_qty
  end

  def create_order(order)
    populate_order(order)
    decrement_product_inventory
  end

  def calculate_order_total(order)
    order.products.map do |product|
      order.order_products.find_by(product_id: product.id).quantity * product.price
    end.reduce(:+)
  end

  private
    def populate_order(order)
      get_prods_and_qty.each do |item|
        # Shove in Product
        order.products << item[:product]

        # Create Product Order Relation for Quantity
        new_order_product = order.order_products.find_by(product_id: item[:product].id)
        new_order_product.quantity = item[:quantity]
        new_order_product.save
      end
    end

    def decrement_product_inventory
      get_prods_and_qty.each do |item|
        # Decrement Product Inventory
        product = Product.find(item[:product].id)
        product.inventory_quantity = product.inventory_quantity - item[:quantity]
        product.save
      end
    end

    def gather_cart_products
      p cart
      cart.keys.map do |product_id|
        Product.find(product_id)
      end
    end

    def merge_prods_with_qty
       gather_cart_products.zip(cart.values).map do |product, quantity|
        {product: product, quantity: quantity}
      end
    end

    def total_cost_of_order(cart_products)
      cart_products.map do |prod_and_qty|
        prod_and_qty[:product].price * prod_and_qty[:quantity]
      end.sum
    end

end
