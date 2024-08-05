# Simulate Pit Stop

Este é um projeto em Ruby on Rails que ajuda iniciantes em automobilismo virtual a saber a hora de reabastecer ou fazer a melhor estratégia de pitstop. O projeto permite selecionar um carro e uma pista, calcular o consumo de combustível por volta e determinar a melhor estratégia de pitstop.

## Funcionalidades

- Seleção de carro e pista
- Cálculo do consumo de combustível por volta
- Cálculo da estratégia de pitstop

## Modelos

### Car

Atributos:
- `model` (string): Nome do modelo do carro
- `power` (integer): Potência do motor
- `weight` (integer): Peso do carro
- `fuel_capacity` (float): Capacidade do tanque de combustível

### Track

Atributos:
- `name` (string): Nome da pista
- `distance` (float): Comprimento da pista
- `number_of_curves` (integer): Número de curvas
- `country` (string): País onde a pista está localizada
- `elevation_track` (float): Elevação da pista

## Requisitos

- Ruby 3.0.0
- Rails 6.1.0
- SQLite3

## Instalação

1. Clone o repositório:

    ```bash
    git clone https://github.com/seu-usuario/simulate-pit-stop.git
    cd simulate-pit-stop
    ```

2. Instale as dependências:

    ```bash
    bundle install
    ```

3. Configure o banco de dados:

    ```bash
    rails db:create
    rails db:migrate
    rails db:seed
    ```

4. Inicie o servidor:

    ```bash
    rails server
    ```

5. Acesse a aplicação no navegador:

    ```
    http://localhost:3000
    ```

## Uso

1. Acesse a página inicial e selecione um carro e uma pista.
2. Informe o consumo de combustível por volta.
3. Clique em "Calcular" para obter a estratégia de pitstop.

## Estrutura do Projeto

### Controladores

- `RacesController`: Controla as ações relacionadas às corridas, como seleção de carro e pista, cálculo de estratégia de pitstop.

### Modelos

- `Car`: Modelo para os carros disponíveis no simulador.
- `Track`: Modelo para as pistas disponíveis no simulador.

### Rotas

```ruby
Rails.application.routes.draw do
  resources :races, only: [:index, :new, :show] do
    post 'calculate_strategy', on: :member
  end

  get 'races/show/:car_id/:track_id', to: 'races#show', as: 'show_race'

  resources :cars, only: [:index, :show, :new, :create, :destroy]
  resources :tracks, only: [:index, :show, :new, :create, :destroy]

  root 'races#index'
end
