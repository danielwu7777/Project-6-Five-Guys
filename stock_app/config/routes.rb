Rails.application.routes.draw do
  resources :owned_stocks
  resources :stocks
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #get 'trade'    => 'stocks#trade'
  #
  get '/stocks/:id/trade', to: 'stocks#trade', as: 'trade'
end
