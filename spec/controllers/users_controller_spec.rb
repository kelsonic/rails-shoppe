require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:new_user) {
    User.create(
      username: "John",
      email: "john@example.com",
      password: "password"
    )
  }

  describe '#new' do

    before(:each) do
      get :new
    end

    it 'responds with a status of 200' do
      expect(response.status).to eq 200
    end

    it 'assigns a user instance variable' do
      expect(assigns(:user)).to be_an_instance_of User
    end
  end

  describe '#create' do

    let(:params) {{"user"=>{
      "username"=>"James",
      "email"=>"james@example.com",
      "password"=>"password"
    }}}

    let(:bad_params) {{"user"=>{
        "username"=>"",
        "email"=>"blah@example.com",
        "password"=>"password"
      }}}

    it 'saves a new user' do
      expect{post :create, params}.to change{User.count}.by(1)
    end

    it 'returns a message if user was not saved' do
      post :create, bad_params
      expect(flash[:errors]).to include "Username can't be blank"
    end
  end

end
