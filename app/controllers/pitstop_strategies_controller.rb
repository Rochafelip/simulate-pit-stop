class PitstopStrategiesController < ApplicationController
  def new
    @race = Race.new
    load_resources
    render :new  # Exibe o formulário para calcular a estratégia de pitstop
  end

  def create
    @race = Race.new(race_params)

    if @race.valid?
      @strategy = PitstopStrategyService.new(
        car: @race.car,
        track: @race.track,
        average_lap_time: @race.average_lap_time,
        fuel_consumption_per_lap: @race.fuel_consumption_per_lap,
        total_laps: @race.total_laps
      ).calculate

      @race.total_fuel_needed = @strategy[:total_fuel_needed]  # Salva o total de combustível necessário

      if @race.save
        redirect_to show_race_path(@race), notice: 'Estratégia de pitstop salva com sucesso.'
      else
        load_resources
        render :new, alert: 'Erro ao salvar a estratégia de pitstop.'
      end
    else
      load_resources
      render :new, alert: 'Erro nos parâmetros da corrida.'
    end
  end

  private

  def race_params
    params.require(:race).permit(:car_id, :track_id, :average_lap_time, :fuel_consumption_per_lap, :total_laps)
  end

  def load_resources
    @cars = Car.all
    @tracks = Track.all
  end
end
