class RacesController < ApplicationController
  before_action :set_car_and_track, only: [:show, :calculate_strategy]

  def index
    @cars = Car.all
    @tracks = Track.all
  end

  def new
    @car = Car.new
    @track = Track.new
    @cars = Car.all
    @tracks = Track.all
  end

  def show
    set_race_params
    @strategy = calculate_pitstop_strategy
  end

  def add_cars_tracks
    @car = Car.new
    @track = Track.new
  end

  def calculate_strategy
    set_race_params
    @strategy = calculate_pitstop_strategy
  end

  private

  def set_car_and_track
    @car = Car.find(params[:car_id])
    @track = Track.find(params[:track_id])
  end

  def set_race_params
    @fuel_consumption_per_lap = params[:fuel_consumption_per_lap].to_f
    @total_laps = params[:total_laps].to_i
  end

  def calculate_pitstop_strategy
    # Recebe os parâmetros da requisição
    average_lap_time = params[:average_lap_time].to_f  # Tempo médio por volta (em segundos)
    fuel_consumption_per_lap = params[:fuel_consumption_per_lap].to_f  # Consumo por volta (em litros)
    total_laps = params[:total_laps].to_i  # Número de voltas
  
    # Carrega o carro e a pista
    car = Car.find(params[:car_id])
    track = Track.find(params[:track_id])
  
    # Calcula o número de voltas que o carro pode dar com um tanque cheio
    laps_per_tank = car.fuel_capacity / fuel_consumption_per_lap
  
    # Calcula a distância total da corrida
    total_race_distance = track.distance * total_laps
  
    # Calcula a quantidade total de combustível necessária
    total_fuel_needed = fuel_consumption_per_lap * total_laps
  
    # Retorna a resposta em formato JSON
    render json: {
      laps_per_tank: laps_per_tank.round(2),  # Arredondamento para 2 casas decimais
      fuel_needed_per_lap: fuel_consumption_per_lap,
      total_race_distance: total_race_distance.round(2),
      total_fuel_needed: total_fuel_needed.round(2),
      total_laps: total_laps
    }
  end  
end
