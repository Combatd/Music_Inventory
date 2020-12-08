class TracksController < ApplicationController
    before_action :require_log_in!

    private # hidden encapsulated data

    def track_params
        params.require(:track).permit(:title, :ord, :lyrics, :album_id, :bonus)
    end
end
