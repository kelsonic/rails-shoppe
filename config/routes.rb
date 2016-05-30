Rails.application.routes.draw do
  root "products#index"

  resources :products
  resources :users, only: [:new, :create]
  resources :categories, only: [:index, :show]
  resources :carts, only: [:new]
  resources :orders, only: [:show, :new, :create]

  # Order History
  resources :users do
    resources :orders, only: [:index]
  end

  get 'my_cart', to: "carts#show"
  get 'login', to: "sessions#new"
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'admin', to: 'admins#index'

  match 'auth/:provider/callback', to: 'sessions#facebook', via: [:get]
  match 'auth/failure', to: redirect('/'), via: [:get]

end
