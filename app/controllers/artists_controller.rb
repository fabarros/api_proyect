require "base64"


class ArtistsController < ApplicationController
  before_action :set_artist, only: [:show, :update, :destroy]

  # GET /artists
  def index
    @artists = Artist.all

    render json: @artists, only: [:id, :name, :age, :albums, :tracks, :self]
  end

  # GET /artists/1
  def show
    render json: @artist, only: [:id, :name, :age, :albums, :tracks, :self]
  end

  def albums
    if Artist.find_by(id: params[:artist_id])
      @albums = Album.where(artist_id: params[:artist_id])
      render json: @albums, only: [:id, :artist_id, :name, :genre, :artist, :tracks, :self]
    else 
      render status: :unprocessable_entity
      return
    end
  end

  def tracks
    if Artist.find_by(id: params[:artist_id])
      @tracks = Track.where(artist_id: params[:artist_id])
      render json: @tracks
    else
      render status: :unprocessable_entity
      return
    end
  end

  # POST /artists
  def create
    if !artist_params[:name] || !artist_params[:age]
      render status: :bad_request
      return
    end 
    id_params = {:id => Base64.encode64(artist_params[:name]).delete!("\n")}
    id_params[:name] = artist_params[:name]
    id_params[:age] = artist_params[:age]
    id_params[:albums] = request.protocol + request.host_with_port + "/artists" + "/#{id_params[:id]}/albums"
    id_params[:tracks] = request.protocol + request.host_with_port + "/artists" + "/#{id_params[:id]}/tracks"
    id_params[:self] = request.protocol + request.host_with_port + "/artists" + "/#{id_params[:id]}"
    @artist = Artist.new(id_params)
    @existed_artist = Artist.find_by(id: id_params[:id])
    
    if @existed_artist
      render json: @existed_artist, status: :conflict, only: [:id, :name, :age, :albums, :tracks, :self]
      return
    elsif @artist.save
      render json: @artist, status: :created, location: @artist, only: [:id, :name, :age, :albums, :tracks, :self]
    else
      render json: @artist.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /artists/1
  def update
    if @artist.update(artist_params)
      render json: @artist
    else
      render json: @artist.errors, status: :unprocessable_entity
    end
  end

  # DELETE /artists/1
  def destroy
    @artist.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_artist
      @artist = Artist.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def artist_params
      params.require(:artist).permit(:name, :age)
    end
end
