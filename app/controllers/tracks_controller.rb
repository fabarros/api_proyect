class TracksController < ApplicationController
  before_action :set_track, only: [:show, :update, :destroy]

  # GET /tracks
  def index
    @tracks = Track.all

    render json: @tracks, only: [:id, :album_id, :name, :duration, :times_played, :artist, :album, :self]
  end

  # GET /tracks/1
  def show
    render json: @track, only: [:id, :album_id, :name, :duration, :times_played, :artist, :album, :self]
  end

  # POST /tracks
  def create
    
    id_params = {:id => Base64.encode64(track_params[:name]+":"+params[:album_id]).delete!("\n")}
    id_params[:name] = track_params[:name]
    id_params[:duration] = track_params[:duration]
    id_params[:album_id] = params[:album_id]
    id_params[:times_played] = 0
    
    @album = Album.find_by(id: params[:album_id])
    if @album
      id_params[:artist_id] = @album.artist_id
    end
    @track = Track.new(id_params)
    
    @existed_track = Track.find_by(id: id_params[:id])

    

    if !@album
      render status: :unprocessable_entity
      return
    elsif @existed_track
      render json: @existed_track, status: :conflict, only: [:id, :album_id, :name, :duration, :times_played, :artist, :album, :self]
      return
    elsif @track.save
      render json: @track, status: :created, location: @track, only: [:id, :album_id, :name, :duration, :times_played, :artist, :album, :self]
    else
      render json: @track.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tracks/1
  def update
    if @track.update(track_params)
      render json: @track
    else
      render json: @track.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tracks/1
  def destroy
    @track.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_track
      @track = Track.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def track_params
      params.require(:track).permit(:id, :name, :duration, :times_played, :artist_id, :album_id, :artist, :album, :self)
    end
end
