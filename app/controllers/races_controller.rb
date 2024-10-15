class RacesController < ApplicationController
  before_action :set_car_and_track, only: [:show]

  def index
    load_resources
    render :overview  # Exibe a visão de listagem de corridas, carros e pistas
  end

  def new
    @race = Race.new
    load_resources
  end

  def show
    @strategy = PitstopStrategyService.new(
      car: @car,
      track: @track,
      average_lap_time: @race.average_lap_time,
      fuel_consumption_per_lap: @race.fuel_consumption_per_lap,
      total_laps: @race.total_laps
    ).calculate

    render :show  # Exibe os detalhes da corrida e a estratégia calculada
  end

  def create
    @race = Race.new(race_params)
    
    # Verifica se todos os parâmetros são maiores que zero
    if race_params.values.any? { |value| value.to_f <= 0 }
      flash[:alert] = "Todos os parâmetros devem ser maiores que zero."
      load_resources
      render :new and return
    end

    if @race.save
      flash[:notice] = "Corrida salva com sucesso!"
      redirect_to @race
    else
      flash[:alert] = "Erro ao salvar a corrida."
      load_resources
      render :new
    end
  end

  private

  def set_car_and_track
    @race = Race.find(params[:id])
    @car = @race.car
    @track = @race.track
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Carro ou pista não encontrado."
    redirect_to races_path
  end

  def race_params
    params.require(:race).permit(:car_id, :track_id, :average_lap_time, :fuel_consumption_per_lap, :total_laps)
  end

  def load_resources
    @cars = Car.all
    @tracks = Track.all
  end
end
