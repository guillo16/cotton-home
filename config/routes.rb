Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  post 'procesar-pago', to: "payments#create"

  resources :categories
  resources :sub_categories
  resources :products do
    resources :variants, only: [:new, :create]
  end

  resources :variants, only: [:show, :edit, :update, :destroy]
  resources :line_items, only: [:show, :create, :destroy] do
    get 'decrease', on: :member
    get 'increase', on: :member
  end
  resources :carts
  resources :users, only: [:index, :show]
  resources :orders, only: [:show, :create] do
    resources :payments, only: :new
  end
end
