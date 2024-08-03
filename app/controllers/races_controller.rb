class RacesController < ApplicationController
  def index
    @cars = Car.all
    @tracks = Track.all
  end

  def new
    @cars = Car.all
    @tracks = Track.all    
  end

  def show
    @car = Car.find(params[:car_id])
    @track = Track.find(params[:track_id])
    @strategy = calculate_pitstop_strategy(@car, @track)
  end

  def calculate_strategy
    @car = Car.find(params[:car_id])
    @track = Track.find(params[:track_id])
    @strategy = calculate_pitstop_strategy(@car, @track)
  end

  private

  def calculate_pitstop_strategy(car, track)
    laps_per_tank = car.fuel_capacity / car.fuel_consumption_per_lap
    total_race_distance = track.length * 100 # Ajuste conforme a lógica da sua corrida
    total_laps = (total_race_distance / track.length).ceil

    {
      laps_per_tank: laps_per_tank.ceil,
      fuel_needed_per_lap: car.fuel_consumption_per_lap,
      total_race_distance: total_race_distance,
      total_laps: total_laps
    }
  end
end
