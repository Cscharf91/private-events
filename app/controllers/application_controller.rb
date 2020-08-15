class ApplicationController < ActionController::Base
    skip_before_action :verify_authenticity_token
    def login_required
        if !logged_in?
            redirect_to login_path, :notice => "Log in to edit or delete your post"
        end
    end

    def logged_in?
        !current_user.nil?
    end

    helper_method :logged_in?

    def current_user
        User.find_by(id: session[:user_id])
    end

    helper_method :current_user
end
