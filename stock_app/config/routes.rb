Rails.application.routes.draw do
  devise_for :users
  resources :owned_stocks
  resources :stocks
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # Created 7/21/22 by Noah Moon
  get '/stocks/:id/trade', to: 'stocks#trade', as: 'trade'
  get '/owned_stocks/:id/buy', to: 'owned_stocks#buy', as: 'buy'
  get '/owned_stocks/:id/sell', to: 'owned_stocks#sell', as: 'sell'
  patch '/owned_stocks/:id/buy_stock', to: 'owned_stocks#buy_stock', as: 'buy_stock'
  patch '/owned_stocks/:id/sell_stock', to: 'owned_stocks#sell_stock', as: 'sell_stock'


end
