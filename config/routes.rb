Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  post 'procesar-pago', to: "payments#create"
  post 'efectivo', to: "payments#transfer"
  get 'pages/search', to: 'pages#search'
  get 'pages/result', to: 'pages#result'
  get '/about', to: 'pages#about'
  get '/terminos-y-condiciones', to: 'pages#terms'

  resources :categories
  resources :sub_categories
  resources :products do
    resources :variants, only: [:new, :create]
  end

  resources :variants, only: [:show, :edit, :update, :destroy]
  resources :line_items, only: [:show, :create, :update, :destroy]
  resources :carts
  resources :users, only: [:index, :show]
  resources :orders, only: [:index, :show, :create] do
    resources :shippings, only: :create
    resources :payments, only: :new
  end
  resources :divisions
  resources :articles do
    resources :dimensions, only: [:new, :create]
  end
  resources :dimensions, only: [:show, :edit, :update, :destroy]
  resources :shippings, only: [:edit, :update]
  resources :payments, only: [:index, :show]
  resources :contacts, only: [:new, :create]
end
