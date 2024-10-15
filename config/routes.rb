Rails.application.routes.draw do
  resources :cars, except: [:edit, :update]  # Rotas para carros
  resources :tracks, except: [:edit, :update]  # Rotas para pistas

  # Rotas para as corridas
  resources :races, except: [:edit, :update] do
    member do
      post 'calculate_strategy'  # Para calcular a estratégia de pitstop para uma corrida específica
    end

    collection do
      get 'add_cars_tracks'       # Para adicionar carros e pistas
      post 'create_cars_tracks'   # Para criar carros e pistas (se necessário)
    end
  end
  
  # Rota para exibir uma corrida específica
  get 'races/show/:car_id/:track_id', to: 'races#show', as: 'show_race'

  # Rotas para estratégias de pitstop
  resources :pitstop_strategies, only: [:new, :create]

  root 'races#index'  # Define a rota raiz para a lista de corridas
end
