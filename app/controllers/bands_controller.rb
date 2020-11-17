class BandsController < ApplicationController


    private # hidden encapsulated data

    def band_params
        params.require(:band).permit(:name)
    end
end
