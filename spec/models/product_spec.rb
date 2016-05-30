require "rails_helper"

RSpec.describe Product, :type => :model do
  let(:product) {
    Product.create(
      name: "Cheerios",
      image_url: "http://www.cheerios.com/~/media/17EE88F6F39C45E787CE2E1186260B94.ashx",
      description: "We believe that Cheerios should be enjoyed by everyone. By simply removing stray wheat, rye and barley grains from the Cheerios’ oat supply, Cheerios will still have the same great taste, but will be gluten-free.",
      inventory_quantity: 34,
      price: 5.99
    )
  }

  it 'has many category_products' do
    expect(product.category_products.class).to eq CategoryProduct::ActiveRecord_Associations_CollectionProxy
  end

  it 'has many categories' do
    expect(product.categories.class).to eq Category::ActiveRecord_Associations_CollectionProxy
  end

  describe 'presence validations' do

    let(:bad_product) {
      Product.new
    }

    it 'has a true presence for name' do
      bad_product.save
      expect(bad_product.errors.full_messages).to include "Name can't be blank"
    end

    it 'has a true presence for image_url' do
      bad_product.save
      expect(bad_product.errors.full_messages).to include "Image url can't be blank"
    end

    it 'has a true presence for description' do
      bad_product.save
      expect(bad_product.errors.full_messages).to include "Description can't be blank"
    end

    it 'has a true presence for inventory quantity' do
      bad_product.save
      expect(bad_product.errors.full_messages).to include "Inventory quantity can't be blank"
    end

    it 'has a true presence for price' do
      bad_product.save
      expect(bad_product.errors.full_messages).to include "Price can't be blank"
    end
  end

  describe 'length constraints' do
    let(:bad_product) {
      Product.new(
        name: "a" * 151,
        image_url: "http://www.cheerios.com/~/media/17EE88F6F39C45E787CE2E1186260B94.ashx",
        description: "a" * 4,
        inventory_quantity: 34,
        price: 5.99
      )
    }

    it 'has a max length of 150 for name' do
      bad_product.save
      expect(bad_product.errors.full_messages).to include "Name is too long (maximum is 150 characters)"
    end

    it 'has a min length of 5 for description' do
      bad_product.save
      expect(bad_product.errors.full_messages).to include "Description is too short (minimum is 5 characters)"
    end
  end

  describe 'numericality constraints' do
    let(:bad_product) {
      Product.create(
        name: "a" * 150,
        image_url: "http://www.cheerios.com/~/media/17EE88F6F39C45E787CE2E1186260B94.ashx",
        description: "a" * 5,
        inventory_quantity: 34.0,
        price: "hello"
      )
    }

    it 'is has a fail message for bad inventory quantity' do
      expect(bad_product.errors.full_messages).to include "Inventory quantity must be an integer"
    end

    it 'has a fail message for bad price value' do
      expect(bad_product.errors.full_messages).to include "Price is not a number"
    end
  end
end
