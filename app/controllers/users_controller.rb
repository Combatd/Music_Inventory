class UsersController < ApplicationController

    def new
        @user = User.new
        render json: @user
    end

    private # hidden encapsulated data methods
    def user_params
        params.require(:user).permit(:email, :password)
    end
end