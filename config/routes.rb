Rails.application.routes.draw do
<<<<<<< HEAD
  resources :cars, except: [:edit, :update]  # Rotas para carros
  resources :tracks, except: [:edit, :update]  # Rotas para pistas

  # Rotas para as corridas
=======
  resources :cars, except: [:edit, :update] # Inclui todas as ações, exceto edit e update
  resources :tracks, except: [:edit, :update] # Inclui todas as ações, exceto edit e update

>>>>>>> main
  resources :races, except: [:edit, :update] do
    member do
      post 'calculate_strategy'  # Para calcular a estratégia de pitstop para uma corrida específica
    end

    collection do
<<<<<<< HEAD
      get 'add_cars_tracks'       # Para adicionar carros e pistas
      post 'create_cars_tracks'   # Para criar carros e pistas (se necessário)
    end
  end
  
  # Rota para exibir uma corrida específica
=======
      get 'add_cars_tracks'
      post 'create_cars_tracks'
      get 'strategies' # Nova rota para visualizar todas as estratégias
    end
  end

>>>>>>> main
  get 'races/show/:car_id/:track_id', to: 'races#show', as: 'show_race'

  # Rotas para estratégias de pitstop
  resources :pitstop_strategies, only: [:new, :create]

  root 'races#index'  # Define a rota raiz para a lista de corridas
end
