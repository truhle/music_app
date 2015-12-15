class AlbumsController < ApplicationController

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to @album
    else
      render :new
    end
  end

  def new
    @band = Band.find(params[:band_id])
    @bands = Band.all.order(:name)
  end

  def show
    @album = Album.find(params[:id])
  end

private

  def album_params
    params.permit(:album_type, :band_id, :name)
  end
end
