class Api::V1::TracksController < ApplicationController
  before_action :set_track, only: [:show, :update, :destroy]

  # GET /tracks
  def index
    @tracks = Track.all
    render json: @tracks, status: :ok
  end

  # GET /tracks/1
  def show
    render json: @track, status: :ok
  end

  # POST /tracks
  def create
    @track = Track.new(track_params)

    if @track.save
      render json: { message: 'Pista adicionada com sucesso.', track: @track }, status: :created
    else
      render json: { error: 'Erro ao adicionar a pista.', details: @track.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tracks/1
  def update
    if @track.update(track_params)
      render json: { message: 'Pista atualizada com sucesso.', track: @track }, status: :ok
    else
      render json: { error: 'Erro ao atualizar a pista.', details: @track.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /tracks/1
  def destroy
    @track.destroy
    render json: { message: 'Pista removida com sucesso.' }, status: :no_content
  end

  private

  def set_track
    @track = Track.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Pista não encontrada.' }, status: :not_found
  end

  def track_params
    params.require(:track).permit(:name, :distance, :number_of_curves, :country, :elevation_track)
  end
end
