Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :categories
  resources :sub_categories
  resources :products
end
