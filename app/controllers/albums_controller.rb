class AlbumsController < ApplicationController

  before_action :must_be_logged_in
  before_action :save_previous_url, only: :show
  before_action :admin_only, except: :show

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to @album
    else
      @band = Band.find(params[:band_id])
      @bands = Band.all.order(:name)
      render :new
    end
  end

  def destroy
    @album = find_album
    @band = @album.band
    if @album.destroy
      redirect_to @band
    else
      redirect_to root_url
    end
  end

  def edit
    @album = find_album
    @band = @album.band
    @bands = Band.all.order(:name)
  end

  def new
    @album = Album.new
    @band = Band.find(params[:band_id])
    @bands = Band.all.order(:name)
  end

  def show
    @album = find_album
  end

  def update
    @album = find_album
    if @album.update(album_params)
      redirect_to @album
    else
      @band = @album.band
      @bands = Band.all.order(:name)
      render :edit
    end
  end

private

  def album_params
    params.permit(:album_type, :band_id, :name)
  end

  def find_album
    Album.find(params[:id])
  end
end
