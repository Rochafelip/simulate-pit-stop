class Api::V1::RacesController < ApplicationController
  before_action :set_race, only: [:show, :update, :destroy]

  # GET /races
  def index
    @races = Race.all
    render json: @races, status: :ok
  end

  # GET /races/1
  def show
    # Calculando a estratégia de pitstop
    strategy = PitstopStrategyService.new(
      car: @race.car,
      track: @race.track,
      average_lap_time: @race.average_lap_time,
      fuel_consumption_per_lap: @race.fuel_consumption_per_lap,
      total_laps: @race.total_laps
    ).calculate

    render json: { race: @race, strategy: strategy }, status: :ok
  end

  # POST /races
  def create
    @race = Race.new(race_params)

    # Validação de parâmetros
    if race_params.values.any? { |value| value.to_f <= 0 }
      render json: { error: 'Todos os parâmetros devem ser maiores que zero.' }, status: :unprocessable_entity
      return
    end

    @race.total_fuel_needed = @race.fuel_consumption_per_lap * @race.total_laps

    if @race.save
      render json: { message: 'Corrida salva com sucesso.', race: @race }, status: :created
    else
      render json: { error: 'Erro ao salvar a corrida.', details: @race.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /races/1
  def update
    if @race.update(race_params)
      render json: { message: 'Corrida atualizada com sucesso.', race: @race }, status: :ok
    else
      render json: { error: 'Erro ao atualizar a corrida.', details: @race.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /races/1
  def destroy
    @race.destroy
    render json: { message: 'Corrida removida com sucesso.' }, status: :no_content
  end

  private

  def set_race
    @race = Race.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Corrida não encontrada.' }, status: :not_found
  end

  def race_params
    params.require(:race).permit(:car_id, :track_id, :average_lap_time, :fuel_consumption_per_lap, :total_laps)
  end
end
