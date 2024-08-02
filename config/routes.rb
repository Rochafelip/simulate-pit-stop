Rails.application.routes.draw do
  
  post 'races/:id/calculate_strategy', to: 'races#calculate_strategy', as: 'calculate_strategy_race'
  get 'races/show/:car_id/:track_id', to: 'races#show', as: 'show_race'

  resources :cars, only: [:index, :show, :new, :create, :destroy]
  resources :tracks, only: [:index, :show, :new, :create, :destroy]
  resources :races, only: [:index, :new, :show]

  root 'races#index'
end
