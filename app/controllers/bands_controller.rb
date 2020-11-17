class BandsController < ApplicationController

    def index
        @bands = Band.all
        render :index
    end

    private # hidden encapsulated data

    def band_params
        params.require(:band).permit(:name)
    end
end
