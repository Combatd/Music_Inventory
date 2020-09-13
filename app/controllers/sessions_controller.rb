class SessionsController < ApplicationController
    before_action :already_signed_in, except: [:destroy]

    def new
        render :new
    end
    
    def create
        user = User.find_by_credentials(params[:user][:email], params[:user][:password])

        if !user
            flash.now[:errors] = ['Wrong username or password entered']
            render :new
        else
            login_user!(user)
            redirect_to root_url
        end
    end
    
end