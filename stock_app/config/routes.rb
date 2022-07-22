Rails.application.routes.draw do
  resources :owned_stocks
  resources :stocks
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # Created 7/21/22 by Noah Moon
  get '/stocks/:id/trade', to: 'stocks#trade', as: 'trade'
  get '/owned_stocks/:id/buy', to: 'owned_stocks#buy', as: 'buy'
  patch '/owned_stocks/:id/buy_stock', to: 'owned_stocks#buy_stock', as: 'buy_stock'


end
