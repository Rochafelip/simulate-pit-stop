Rails.application.routes.draw do
  resources :cars, except: [:edit, :update] # Inclui todas as ações, exceto edit e update
  resources :tracks, except: [:edit, :update] # Inclui todas as ações, exceto edit e update

  resources :races, except: [:edit, :update] do
    member do
      post 'calculate_strategy'
    end

    collection do
      get 'add_cars_tracks'
      post 'create_cars_tracks'
      get 'strategies' # Nova rota para visualizar todas as estratégias
    end
  end

  get 'races/show/:car_id/:track_id', to: 'races#show', as: 'show_race'

  root 'races#index'
end
