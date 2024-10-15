class RacesController < ApplicationController
  before_action :set_race_params, only: [:create, :show, :calculate_strategy]

  def index
    load_resources
  end

  def create
    @race = Race.new(race_params)

    @race.total_fuel_needed = @race.fuel_consumption_per_lap * @race.total_laps
    if @race.save
      # Calcular a estratégia de pitstop aqui, se necessário
      redirect_to race_path(@race) # Passa o objeto @race com o id automaticamente
    else
      load_resources
      render :new
    end
  end

  def new
    @car = Car.new
    @track = Track.new
    load_resources
  end

  def show
    @strategy = calculate_pitstop_strategy
  end

  def calculate_strategy
    @strategy = calculate_pitstop_strategy
    # Criação de uma corrida e salvamento (opcional, dependendo do fluxo)
    @race = Race.create(
      car_id: params[:car_id],
      track_id: params[:track_id],
      fuel_consumption_per_lap: params[:fuel_consumption_per_lap],
      total_laps: params[:total_laps],
      average_lap_time: params[:average_lap_time] # Adicionando aqui
    )
    # Calcule o total de combustível necessário
    @race.total_fuel_needed = @race.fuel_consumption_per_lap * @race.total_laps

    if @race.save
      redirect_to race_path(@race)
    else
      load_resources
      render :new
    end
  end

  def strategies
    @races = Race.includes(:car, :track).all
  end

  private

  def race_params
    params.permit(:car_id, :track_id, :fuel_consumption_per_lap, :total_laps, :average_lap_time)
  end

  # Carrega os parâmetros da corrida
  def set_race_params
    @fuel_consumption_per_lap = params[:fuel_consumption_per_lap].to_f
    @total_laps = params[:total_laps].to_i
    @average_lap_time = params[:average_lap_time].to_f

    if @fuel_consumption_per_lap <= 0 || @total_laps <= 0 || @average_lap_time <= 0
      render json: { error: "Consumo de combustível, total de voltas e tempo médio devem ser maiores que zero." },
             status: :unprocessable_entity
    end
  end

  # Usa o Service Object para calcular a estratégia
  def calculate_pitstop_strategy
    strategy_service = PitstopStrategyService.new(
      car: @car,
      track: @track,
      average_lap_time: @average_lap_time, # Usando o parâmetro do método set_race_params
      fuel_consumption_per_lap: @fuel_consumption_per_lap,
      total_laps: @total_laps
    )

    strategy_service.calculate
  end

  # Carrega todos os carros e pistas
  def load_resources
    @cars = Car.all
    @tracks = Track.all
  end
end
