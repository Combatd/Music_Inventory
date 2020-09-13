class SessionsController < ApplicationController
    before_action :already_signed_in, except: [:destroy]

    def new
        render :new
    end
end