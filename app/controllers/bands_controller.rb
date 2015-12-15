class BandsController < ApplicationController

  before_action :must_be_logged_in

  def create
    @band = Band.new(band_params)
    if @band.save
      redirect_to @band
    else
      render :new
    end
  end

  def destroy
    find_band
    if @band.destroy
      redirect_to bands_url
    else
      redirect_to root_url
    end
  end

  def edit
    find_band
  end

  def index
    @bands = Band.all.order(:name)
  end

  def new
    @band = Band.new
  end

  def show
    find_band
  end

  def update
    find_band
    if @band.update(band_params)
      redirect_to @band
    else
      render :edit
    end
  end

private

  def band_params
    params.permit(:name)
  end

  def find_band
    @band = Band.find(params[:id])
  end
end
