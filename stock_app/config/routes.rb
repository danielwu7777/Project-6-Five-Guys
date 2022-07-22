Rails.application.routes.draw do
  get 'home/index'
  devise_for :users
  root to: "home#index"
  resources :owned_stocks
  resources :stocks
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
