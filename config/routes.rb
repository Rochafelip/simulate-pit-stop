Rails.application.routes.draw do
  resources :cars, except: [:edit, :update]
  resources :tracks, except: [:edit, :update]
  resources :pitstop_strategies, only: [:new, :create]
  
  resources :races, except: [:edit, :update] do
    member do
      get 'add_cars_tracks'
      post 'create_cars_tracks'
    end
  end

  root 'races#index'
end
