Rails.application.routes.draw do
  resources :races, only: [:index, :new, :show] do
    post 'calculate_strategy', on: :member
  end

  get 'races/show/:car_id/:track_id', to: 'races#show', as: 'show_race'

  resources :cars, only: [:index, :show, :new, :create, :destroy]
  resources :tracks, only: [:index, :show, :new, :create, :destroy]

  root 'races#index'
end
