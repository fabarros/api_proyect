class AlbumsController < ApplicationController
  before_action :set_album, only: [:show, :update, :destroy]

  # GET /albums
  def index
    @albums = Album.all

    render json: @albums, only: [:id, :artist_id, :name, :genre, :artist, :tracks, :self]
  end

  # GET /albums/1
  def show
    render json: @album, only: [:id, :artist_id, :name, :genre, :artist, :tracks, :self]
  end

  def tracks
    if Album.find_by(id: params[:album_id])
      @tracks = Track.where(album_id: params[:album_id])
      render json: @tracks, only: [:id, :album_id, :name, :duration, :times_played, :artist, :album, :self]
    else
      render status: :unprocessable_entity
      return
    end
  end

  def play
    if Album.find_by(id: params[:album_id])
      @tracks = Track.where(album_id: params[:album_id])
      @tracks.each do |track|
        track.update(times_played: track.times_played + 1)
      end
      render status: :ok
    else
      render status: :not_found
    end
  end

  # POST /albums
  def create

    if !album_params[:name] || !album_params[:genre]
      render status: :bad_request
      return
    end


    id_params = {:id => Base64.encode64(album_params[:name]+":"+params[:artist_id]).delete!("\n")}
    id_params[:name] = album_params[:name]
    id_params[:genre] = album_params[:genre]
    id_params[:artist_id] = params[:artist_id]
    id_params[:artist] = request.protocol + request.host_with_port + "/artists" + "/#{params[:artist_id]}"
    id_params[:tracks] = request.protocol + request.host_with_port + "/albums" + "/#{id_params[:id]}/tracks"
    id_params[:self] = request.protocol + request.host_with_port + "/albums" + "/#{id_params[:id]}"

    @album = Album.new(id_params)
    @artist = Artist.find_by(id: params[:artist_id])
    @existed_album = Album.find_by(id: id_params[:id])

    if !@artist
      render status: :unprocessable_entity
      return
    elsif @existed_album
      render json: @existed_album, status: :conflict, only: [:id, :artist_id, :name, :genre, :artist, :tracks, :self]
      return
    elsif @album.save
      render json: @album, status: :created, location: @album, only: [:id, :artist_id, :name, :genre, :artist, :tracks, :self]
    else
      render json: @album.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /albums/1
  def update
    if @album.update(album_params)
      render json: @album
    else
      render json: @album.errors, status: :unprocessable_entity
    end
  end

  # DELETE /albums/1
  def destroy
    @album.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_album
      @album = Album.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def album_params
      params.require(:album).permit(:name, :genre)
    end
end
