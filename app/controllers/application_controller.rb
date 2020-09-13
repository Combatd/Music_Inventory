class ApplicationController < ActionController::Base
    helper_method :current_user, :logged_in?

    private

    def log_in_user!(user)
        user.reset_session_token!
        session[:session_token] = user.session_token
    end
end
