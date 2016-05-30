class Category < ActiveRecord::Base

  has_many :products, through: :category_products
  has_many :category_products

  validates :name, presence: true, length: {maximum: 75}

end
