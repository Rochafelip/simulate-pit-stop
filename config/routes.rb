Rails.application.routes.draw do
  # Rotas do Devise Token Auth
  mount_devise_token_auth_for 'User', at: 'api/v1/auth'

  # Outras rotas da API
  namespace :api do
    namespace :v1 do
      resources :cars, only: [:create, :index, :show, :update, :destroy]
      resources :tracks, only: [:create, :index, :show, :update, :destroy]
      resources :races, only: [:create, :index, :show, :update, :destroy]
      resources :users, only: [:create, :index, :show, :update, :destroy]
    end
  end
end
