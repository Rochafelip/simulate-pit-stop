class RacesController < ApplicationController
  before_action :set_race_params, only: [:show, :calculate_strategy]

  def index
    load_resources
  end

  def create
    puts params.inspect
    @race = Race.new(race_params)
  
    if @race.save
      redirect_to race_path(@race) # Passa o objeto @race com o id automaticamente
    else
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

  def add_cars_tracks
    @car = Car.new
    @track = Track.new
  end

   def calculate_strategy
    @strategy = calculate_pitstop_strategy

    # Cria e salva a corrida com as informações fornecidas no formulário
  @race = Race.create(
    car_id: params[:car_id],
    track_id: params[:track_id],
    fuel_consumption_per_lap: params[:fuel_consumption_per_lap],
    total_laps: params[:total_laps]
  )
    if @race.persisted?
    # Opcional: Salva a estratégia de pitstop junto com a corrida
    PitstopStrategy.create(
      race: @race,
      strategy_data: @strategy # Assumindo que strategy é um hash ou similar
    )
    render json: { success: "Corrida e estratégia salvas com sucesso!", strategy: @strategy }
    else
    render json: { error: "Erro ao salvar a corrida." }, status: :unprocessable_entity
    end
    render json: @strategy
  end

  private

  def race_params
    params.permit(:car_id, :track_id, :fuel_consumption_per_lap, :total_laps)
  end

  # Carrega os parâmetros da corrida
  def set_race_params
    @fuel_consumption_per_lap = params[:fuel_consumption_per_lap].to_f
    @total_laps = params[:total_laps].to_i

    if @fuel_consumption_per_lap <= 0 || @total_laps <= 0
      render json: { error: "Consumo de combustível e total de voltas devem ser maiores que zero." }, status: :unprocessable_entity
    end
  end

  # Usa o Service Object para calcular a estratégia
  def calculate_pitstop_strategy
    strategy_service = PitstopStrategyService.new(
      car: @car,
      track: @track,
      average_lap_time: params[:average_lap_time].to_f,
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
