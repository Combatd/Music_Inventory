class UsersController < ApplicationController

    def new
        @user = User.new
        render :new # Page for creating new User
    end

    def create
        @user = User.new(user_params) # created user
        if @user.save
            redirect_to root_url
        else
            flash.new[:errors] = @user.errors.full_messages
            render :new # Page for creating new user
        end
    end

    def show
        @user = User.find(params[:id])
        render :show
    end

    private # hidden encapsulated data methods
    def user_params
        params.require(:user).permit(:email, :password)
    end
end