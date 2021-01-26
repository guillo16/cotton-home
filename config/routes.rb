Rails.application.routes.draw do
  get 'articles/index'
  get 'articles/show'
  get 'articles/edit'
  get 'articles/new'
  get 'divisions/index'
  get 'divisions/show'
  get 'divisions/edit'
  get 'divisions/new'
  devise_for :users
  root to: 'pages#home'
  post 'procesar-pago', to: "payments#create"
  get 'pages/search', to: 'pages#search'
  get 'pages/result', to: 'pages#result'

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
    resources :payments, only: :new
  end
end
