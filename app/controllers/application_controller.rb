class ApplicationController < ActionController::Base
    helper_method :current_user, :logged_in?

    private

    def log_in_user!(user)
        user.reset_session_token!
        session[:session_token] = user.session_token
    end

    def log_out_user!
        current_user.reset_session_token!
        session[:session_token] = nil
    end
end
