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
    @fuel_consumption_per_lap = params[:fuel_consumption_per_lap].to_f
    @total_laps = params[:total_laps].to_i

    @strategy = calculate_pitstop_strategy(@car, @track, @fuel_consumption_per_lap, @total_laps)
  
  end

  def calculate_strategy
    @car = Car.find(params[:car_id])
    @track = Track.find(params[:track_id])
    @strategy = calculate_pitstop_strategy(@car, @track)
  end

  private

  def calculate_pitstop_strategy(car, track, fuel_consumption_per_lap, total_laps)
    laps_per_tank = car.fuel_capacity / fuel_consumption_per_lap
    total_race_distance = track.distance * total_laps
    
    {
      laps_per_tank: laps_per_tank,
      fuel_needed_per_lap: fuel_consumption_per_lap,
      total_race_distance: total_race_distance,
      total_laps: total_laps
    }
  end
end
