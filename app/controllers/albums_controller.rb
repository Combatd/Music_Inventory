class AlbumsController < ApplicationController
    # albums is nested in bands - no index action
    def show
      @album = Album.find(params[:id])
      render :show
    end

    def new
      @album = Album.new(band_id: params[:band_id]) 
      @band = Band.find(params[:band_id])
      render :new
    end

    private # hidden encapsulated data

    def album_params
      params.require(:album).permit(:title, :year, :band_id, :live!)
    end 
end
