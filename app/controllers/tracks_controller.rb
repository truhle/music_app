class TracksController < ApplicationController

  before_action :must_be_logged_in

  def create
    @track = Track.new(track_params)
    if @track.save
      redirect_to @track
    else
      render :new
    end
  end

  def destroy
    @track = find_track
    @album = @track.album
    if @track.destroy
      redirect_to @album
    else
      redirect_to root_url
    end
  end

  def edit
    @track = find_track
    @album = @track.album
    @same_band_albums = @album.same_band_albums
  end

  def new
    @album = Album.find(params[:album_id])
    @same_band_albums = @album.same_band_albums
  end

  def show
    @track = find_track
    @album = @track.album
  end

  def update
    @track = find_track
    if @track.update(track_params)
      redirect_to @track
    else
      render :edit
    end
  end


private

  def find_track
    Track.find(params[:id])
  end

  def track_params
    params.permit(:album_id, :lyrics, :name, :track_type)
  end
end
