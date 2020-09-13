class UsersController < ApplicationController

    def new
        @user = User.new
        render json: @user
    end

end