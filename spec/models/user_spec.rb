require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {
    User.create(
      username: "kelsonic",
      email: "kelsonic@example.com",
      password: "password"
    )
  }

  it 'has a username' do
    expect(user.username).to eq "kelsonic"
  end

  it 'has an email' do
    expect(user.email).to eq "kelsonic@example.com"
  end

  it 'has a password' do
    expect(user.authenticate("password")).to eq user
  end

end
