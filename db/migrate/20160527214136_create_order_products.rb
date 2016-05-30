class CreateOrderProducts < ActiveRecord::Migration
  def change
    create_table :order_products do |t|
      t.references :product, index: true
      t.references :order, index: true
      t.integer :quantity

      t.timestamps
    end
  end
end
