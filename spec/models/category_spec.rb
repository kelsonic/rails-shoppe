require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) {
    Category.create(
      name: "Category Name"
    )
  }

  it 'has many category_products' do
    expect(category.category_products.class).to eq CategoryProduct::ActiveRecord_Associations_CollectionProxy
  end

  it 'has many products' do
    expect(category.products.class).to eq Product::ActiveRecord_Associations_CollectionProxy
  end

  describe 'presence validations' do

    let(:bad_category) {
      Category.new
    }

    it 'has a true presence for name' do
      bad_category.save
      expect(bad_category.errors.full_messages).to include "Name can't be blank"
    end

  end

  describe 'length constraints' do

    let(:bad_category) {
      Category.new(
        name: "a" * 76
      )
    }

    it 'has a length constraint for name' do
      bad_category.save
      expect(bad_category.errors.full_messages).to include "Name is too long (maximum is 75 characters)"
    end

  end

end
