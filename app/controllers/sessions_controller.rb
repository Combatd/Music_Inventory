class SessionsController < ApplicationController
    before_action :already_signed_in, except: [:destroy]

    
end