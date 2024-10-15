class RacesController < ApplicationController
  before_action :set_car_and_track, only: [:show]
  before_action :set_race_params, only: [:show, :create]

  def index
    load_resources
    render :overview  # Exibe a visão de listagem de corridas, carros e pistas
  end

  def new
    @race = Race.new
    load_resources
    render :new  # Exibe o formulário de nova corrida
  end

  def show
    @strategy = PitstopStrategyService.new(
      car: @car,
      track: @track,
      average_lap_time: @average_lap_time,
      fuel_consumption_per_lap: @fuel_consumption_per_lap,
      total_laps: @total_laps
    ).calculate
    render :show  # Exibe os detalhes da corrida e a estratégia calculada
  end

  def create
    @race = Race.new(race_params)

    if @race.save
      redirect_to show_race_path(@race), notice: 'Corrida criada com sucesso.'
    else
      load_resources
      render :new, alert: 'Erro ao salvar corrida.'
    end
  end

  private

  def set_car_and_track
    @car = Car.find(params[:car_id])
    @track = Track.find(params[:track_id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Carro ou pista não encontrado." }, status: :not_found
  end

  def set_race_params
    @average_lap_time = params[:average_lap_time].to_f
    @fuel_consumption_per_lap = params[:fuel_consumption_per_lap].to_f
    @total_laps = params[:total_laps].to_i

    if @average_lap_time <= 0 || @fuel_consumption_per_lap <= 0 || @total_laps <= 0
      render json: { error: "Todos os parâmetros devem ser maiores que zero." }, status: :unprocessable_entity
    end
  end

  def race_params
    params.require(:race).permit(:car_id, :track_id, :average_lap_time, :fuel_consumption_per_lap, :total_laps)
  end

  def load_resources
    @cars = Car.all
    @tracks = Track.all
  end
end
