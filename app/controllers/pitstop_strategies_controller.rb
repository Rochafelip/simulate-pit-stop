class PitstopStrategiesController < ApplicationController
  def new
    @race = Race.new
    load_resources
    render :new
  end

  def create
    @race = Race.new(pitstop_strategy_params)
    puts "Parâmetros recebidos: #{params.inspect}"

    # Validação para garantir que os parâmetros são maiores que zero
    if pitstop_strategy_params.values.any? { |value| value.to_f <= 0 }
      flash[:alert] = "Todos os parâmetros devem ser maiores que zero."
      load_resources
      render :new and return
    end

    if @race.save
      @strategy = PitstopStrategyService.new(
        car: @race.car,
        track: @race.track,
        average_lap_time: @race.average_lap_time,
        fuel_consumption_per_lap: @race.fuel_consumption_per_lap,
        total_laps: @race.total_laps
      ).calculate

      # Atribui o resultado da estratégia à corrida
      @race.update(total_fuel_needed: @strategy[:total_fuel_needed])

      flash[:notice] = "Estratégia de pitstop salva com sucesso."
      redirect_to show_race_path(@race)
    else
      flash[:alert] = "Erro ao salvar a corrida. Verifique os parâmetros."
      load_resources
      render :new
    end
  end

  private

  def pitstop_strategy_params
    params.require(:race).permit(:car_id, :track_id, :average_lap_time, :fuel_consumption_per_lap, :total_laps)
  end

  def load_resources
    @cars = Car.all
    @tracks = Track.all
  end
end
