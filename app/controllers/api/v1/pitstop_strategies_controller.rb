class Api::V1::PitstopStrategiesController < ApplicationController
  before_action :authenticate_user!

  def create
    @race = Race.new(pitstop_strategy_params)
    puts "Parâmetros recebidos: #{params.inspect}"

    # Validação para garantir que os parâmetros são maiores que zero
    if pitstop_strategy_params.values.any? { |value| value.to_f <= 0 }
      render json: { error: "Todos os parâmetros devem ser maiores que zero." }, status: :unprocessable_entity and return
    end

    if @race.save
      # Calcula a estratégia de pitstop
      @strategy = PitstopStrategyService.new(
        car: @race.car,
        track: @race.track,
        average_lap_time: @race.average_lap_time,
        fuel_consumption_per_lap: @race.fuel_consumption_per_lap,
        total_laps: @race.total_laps
      ).calculate

      # Atribui o resultado da estratégia à corrida
      @race.update(total_fuel_needed: @strategy[:total_fuel_needed])

      render json: { message: "Estratégia de pitstop salva com sucesso.", race: @race }, status: :created
    else
      render json: { error: "Erro ao salvar a corrida. Verifique os parâmetros." }, status: :unprocessable_entity
    end
  end

  private

  def pitstop_strategy_params
    params.require(:race).permit(:car_id, :track_id, :average_lap_time, :fuel_consumption_per_lap, :total_laps)
  end
end
