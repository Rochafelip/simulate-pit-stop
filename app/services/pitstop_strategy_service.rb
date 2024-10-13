# app/services/pitstop_strategy_service.rb
class PitstopStrategyService
    def initialize(car:, track:, average_lap_time:, fuel_consumption_per_lap:, total_laps:)
      @car = car
      @track = track
      @average_lap_time = average_lap_time
      @fuel_consumption_per_lap = fuel_consumption_per_lap
      @total_laps = total_laps
    end
  
    def calculate
      laps_per_tank = @car.fuel_capacity / @fuel_consumption_per_lap
      total_race_distance = @track.distance * @total_laps
      total_fuel_needed = @fuel_consumption_per_lap * @total_laps
  
      {
        laps_per_tank: laps_per_tank.round(2),
        fuel_needed_per_lap: @fuel_consumption_per_lap,
        total_race_distance: total_race_distance.round(2),
        total_fuel_needed: total_fuel_needed.round(2),
        total_laps: @total_laps
      }
    end
  end
  