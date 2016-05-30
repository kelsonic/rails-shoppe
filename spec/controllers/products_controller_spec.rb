require "rails_helper"
require 'support/macros'

RSpec.describe ProductsController, :type => :controller do

  let(:new_product) {Product.create(
    name: "Cheerios",
    image_url: "http://www.cheerios.com/~/media/17EE88F6F39C45E787CE2E1186260B94.ashx",
    description: "We believe that Cheerios should be enjoyed by everyone. By simply removing stray wheat, rye and barley grains from the Cheerios’ oat supply, Cheerios will still have the same great taste, but will be gluten-free.",
    inventory_quantity: 34,
    price: 5.99
  )}

  describe '#index' do
    before(:each) do
      get :index
    end
    it 'responds with a status of 200' do
      expect(response.status).to eq 200
    end
    it 'assigns the products instance variable' do
      expect(assigns(:products)).to be_an Array
    end
  end

  describe '#create' do

    before(:each) do
      @john = User.create!(username: "john", email: "john@example.com", password: "password", admin: true)
    end

    let(:params) {{"product"=>{
      "name"=>"Cheerios",
      "image_url"=>"https://upload.wikimedia.org/wikipedia/en/6/65/Wiki_cheerios.jpg",
      "description"=>"We’re stepping up to help the bees. These hard workers are, in some way, responsible for about 80\% of our food.¹ By planting pollinator habitats on oat farms across North America, we're helping to get bees back on their own six feet.",
      "inventory_quantity"=>"3",
      "price"=>"3.99"
    }}}

    context "logged-in user" do

      it 'can create a product' do
        login_user @john
        expect{post :create, params}.to change{Product.count}.by(1)
      end

    end

  end

  describe '#show' do
    before(:each) do
      get :show, id: new_product.id
    end
    it 'should render the show page' do
      expect(response).to have_rendered('products/show')
    end
    it 'assigns the product instance variable' do
      expect(assigns(:product)).to be_an_instance_of Product
    end
  end

  describe '#new' do
    before do
      @john = User.create!(username: "john", email: "john@example.com", password: "password", admin: true)
      login_user @john
      get :new
    end

    it 'should render the new page' do
      expect(response).to have_rendered('products/new')
    end

    it 'assigns the new product instance variable' do
      expect(assigns(:product)).to be_an_instance_of Product
    end

  end

  describe '#edit' do
    before(:each) do
      @john = User.create!(username: "john", email: "john@example.com", password: "password", admin: true)
      login_user @john
      get :edit, id: new_product.id
    end
    it 'responds with a status of 200' do
      expect(response.status).to eq 200
    end
    it 'assigns the product instance variable' do
      expect(assigns(:product)).to be_an_instance_of Product
    end
  end

  describe '#update' do

  end

  describe '#destroy' do

  end

end
