Rails.application.routes.draw do

  root "post#index"
  resources :posts
  get 'gruff/show'
  resources :owned_stocks
  resources :stocks
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
