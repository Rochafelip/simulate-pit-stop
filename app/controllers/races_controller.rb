class RacesController < ApplicationController
  before_action :set_car_and_track, only: [:show, :calculate_strategy]
  before_action :set_race_params, only: [:show, :calculate_strategy]

  def index
    load_resources
  end

  def new
    @car = Car.new
    @track = Track.new
    load_resources
  end

  def show
    @strategy = calculate_pitstop_strategy
  end

  def add_cars_tracks
    @car = Car.new
    @track = Track.new
  end

   def calculate_strategy
    @strategy = calculate_pitstop_strategy
    render json: @strategy
  end

  private

  def set_car_and_track
    @car = Car.find(params[:car_id])
    @track = Track.find(params[:track_id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Carro ou pista não encontrado." }, status: :not_found
  end

  # Carrega os parâmetros da corrida
  def set_race_params
    @fuel_consumption_per_lap = params[:fuel_consumption_per_lap].to_f
    @total_laps = params[:total_laps].to_i

    if @fuel_consumption_per_lap <= 0 || @total_laps <= 0
      render json: { error: "Consumo de combustível e total de voltas devem ser maiores que zero." }, status: :unprocessable_entity
    end
  end

  # Usa o Service Object para calcular a estratégia
  def calculate_pitstop_strategy
    strategy_service = PitstopStrategyService.new(
      car: @car,
      track: @track,
      average_lap_time: params[:average_lap_time].to_f,
      fuel_consumption_per_lap: @fuel_consumption_per_lap,
      total_laps: @total_laps
    )

    strategy_service.calculate
  end
  # Carrega todos os carros e pistas
  def load_resources
    @cars = Car.all
    @tracks = Track.all
  end  
end
