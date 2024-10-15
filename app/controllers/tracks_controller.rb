class TracksController < ApplicationController
  before_action :set_track, only: [:show, :update, :destroy]

  # GET /tracks
  def index
    @tracks = Track.all

    render json: @traks
  end

  # GET /tracks/1
  def show
    render json: @track
  end

  def new
    @track = Track.new
  end

  # POST /track
  def create
    @track = Track.new(track_params)
    if @track.save
      redirect_to tracks_path, notice: 'Pista adicionada com sucesso.'
    else
      render :new
    end
  end

  # PATCH/PUT /tracks/1
  def update
    if @track.update(track_params)
      redirect_to @track, notice: 'Pista atualizada com sucesso.'
    else
      render :edit
    end
  end

  # DELETE /tracks/1
  def destroy
    @track.destroy
    redirect_to tracks_path, notice: 'Pista removida com sucesso.'
  end

  private

  def set_track
    @track = Track.find(params[:id])
  end

  def track_params
    params.require(:track).permit(:name, :distance, :number_of_curves, :country, :elevation_track)
  end
end
