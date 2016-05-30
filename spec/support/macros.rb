def login_user(user)
  allow(controller).to receive(:current_user) { user }
end
