class TracksController < ApplicationController
    before_action :require_log_in!

    def new
        @album = Album.find(params[:album_id])
        @band = Band.find(params[@album.band_id]
        @track = Track.new(album_id: params[:album_id]))
        render :new
    end

    private # hidden encapsulated data

    def track_params
        params.require(:track).permit(:title, :ord, :lyrics, :album_id, :bonus)
    end
end
