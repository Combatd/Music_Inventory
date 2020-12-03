class AlbumsController < ApplicationController
    # albums is nested in bands - no index action
    def show
      @album = Album.find(params[:id])
      render :show
    end

    private # hidden encapsulated data

   def album_params
    params.require(:album).permit(:title, :year, :band_id, :live!)
   end 
end
