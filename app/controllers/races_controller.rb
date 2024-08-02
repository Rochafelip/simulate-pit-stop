class RacesController < ApplicationController
  # Desabilita a verificação CSRF para todas as ações deste controlador
  skip_before_action :verify_authenticity_token, only: [:calculate_strategy]

  def index
    @cars = Car.all
    @tracks = Track.all
  end

  def new
    @races = Race.new
  end

  def show
    @car = Car.find_by(id: params[:car_id])
    @track = Track.find_by(id: params[:track_id])
    if @car.nil? || @track.nil?
      redirect_to races_path, alert: "Carro ou pista não encontrados."
    end
  end

  def calculate_strategy
    @car = Car.find(params[:car_id])
    @track = Track.find(params[:track_id])
    fuel_consumption_per_lap = params[:fuel_consumption_per_lap].to_f

    @pitstop_strategy = calculate_pitstop_strategy(@car, @track, fuel_consumption_per_lap)

    render :show
  end

  private

  def calculate_pitstop_strategy(car, track, fuel_consumption_per_lap)
    laps_per_tank = car.fuel_capacity / fuel_consumption_per_lap
    total_race_distance = track.length * 100 # Ajuste conforme a lógica da sua corrida
    total_laps = (total_race_distance / track.length).ceil

    pitstops_needed = (total_laps / laps_per_tank).ceil - 1

    {
      laps_per_tank: laps_per_tank,
      fuel_needed_per_lap: fuel_consumption_per_lap,
      total_race_distance: total_race_distance,
      total_laps: total_laps,
      pitstops_needed: pitstops_needed
    }
  end
end
