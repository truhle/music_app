class TracksController < ApplicationController

  before_action :must_be_logged_in
  before_action :save_previous_url, only: :show

  def create
    @track = Track.new(track_params)
    if @track.save
      redirect_to @track
    else
      @album = Album.find(params[:album_id])
      @same_band_albums = @album.same_band_albums
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
    @track = Track.new
    @album = Album.find(params[:album_id])
    @same_band_albums = @album.same_band_albums
  end

  def show
    @track = find_track
    @album = @track.album
    @notes = @track.notes
  end

  def update
    @track = find_track
    if @track.update(track_params)
      redirect_to @track
    else
      @album = @track.album
      @same_band_albums = @album.same_band_albums
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
