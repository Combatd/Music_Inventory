class TracksController < ApplicationController
    # before_action :require_log_in! will be needed later

    def new
        @album = Album.find(params[:album_id])
        @band = Band.find(@album.band_id)
        @track = Track.new(album_id: params[:album_id])
        render :new
    end

    def create
        @track = Track.new(track_params)

        if @track.save!
            redirect_to track_url(@track)
        else
            flash.now[:errors] = @track.errors.full_messages
            render :new
        end
    end

    def edit
        @track = Track.find(params[:id])
        render :edit
    end

    private # hidden encapsulated data

    def track_params
        params.require(:track).permit(:title, :ord, :lyrics, :album_id, :bonus)
    end
end
