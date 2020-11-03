Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :categories
  resources :sub_categories
  resources :products do
    resources :variants, only: [:new, :create]
  end

  resources :variants, only: [:show, :edit, :update, :destroy]

  resources :line_items
  resources :carts
end
