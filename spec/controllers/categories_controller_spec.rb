require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do

  describe '#index' do

    before(:each) do
      get :index
    end

    it 'responds with a status of 200' do
      expect(response.status).to eq 200
    end

    it 'assigns a users instance variable' do
      expect(assigns(:categories)).to be_a Category::ActiveRecord_Relation
    end

  end

  describe '#show' do

    let(:category) {
      Category.create(
        name: "Category Here"
      )
    }

    before(:each) do
      get :show, id: category.id
    end

    it 'responds with a status of 200' do
      expect(response.status).to eq 200
    end

    it 'assigns a users instance variable' do
      expect(assigns(:category)).to be_an_instance_of Category
    end

  end

end
