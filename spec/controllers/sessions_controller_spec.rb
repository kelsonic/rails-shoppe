require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  it 'servers the login page' do
    get :new
    expect(response.status).to eq(200)
  end
end

describe "the signin process", type: :feature do

  before :each do
    User.create(:username => 'username', :email => 'user@example.com', :password => 'password')
  end
  it "signs me in" do
    visit login_path
    fill_in 'Email', :with => 'user@example.com'
    fill_in 'Password', :with => 'password'
    click_button 'Log in'
    expect(page).to have_content 'Welcome'
  end
end
