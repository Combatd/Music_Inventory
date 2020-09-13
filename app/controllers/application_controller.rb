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

    def current_user
        return nil if !session[:session_token]
        @current_user ||= User.find_by(session_token: session[:session_token]) # find user session if nil value for current_user
    end

    def logged_in?
        return false if !current_user
        true # returns true if current_user is truthy
    end
end
