Rails.application.routes.draw do
  resources :races, only: [:index, :new, :show] do
    post 'calculate_strategy', on: :member
  end

  get 'races/show/:car_id/:track_id', to: 'races#show', as: 'show_race'
  #post 'races/calculate_strategy', to: 'races#calculate_strategy', as: 'calculate_strategy_race'

  resources :cars, only: [:index, :show, :new, :create, :destroy]
  resources :tracks, only: [:index, :show, :new, :create, :destroy]
end
