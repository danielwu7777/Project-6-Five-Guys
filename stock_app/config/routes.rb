Rails.application.routes.draw do
  resources :transactions
  devise_for :users
  resources :owned_stocks
  resources :stocks
  resources :users

  # Created 7/22/22 by Noah Moon: feel free to change this
  # Home Page
  authenticated :user do
      root to: "stocks#index"
  end

  # Created 7/22/22 by Noah Moon
  # Sends non-logged in users to sign-in page
  unauthenticated :user do
    root 'users#new', as: :unauthenticated_root
  end
  # Created 7/21/22 by Noah Moon
  get '/stocks/:id/trade', to: 'stocks#trade', as: 'trade'
  get '/owned_stocks/:id/buy', to: 'owned_stocks#buy', as: 'buy'
  get '/owned_stocks/:id/sell', to: 'owned_stocks#sell', as: 'sell'
  patch '/owned_stocks/:id/buy_stock', to: 'owned_stocks#buy_stock', as: 'buy_stock'
  patch '/owned_stocks/:id/sell_stock', to: 'owned_stocks#sell_stock', as: 'sell_stock'


end
