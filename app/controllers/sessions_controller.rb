class SessionsController < ApplicationController
    def new
        @user = User.new
    end

    def create
        @user = User.find_by(name: params[:name])
          if @user
            session[:user_id] = @user.id
            redirect_to root_path
          else
            redirect_to '/login', :notice => "Invalid login name."
          end
    end

    def destroy
        reset_session
        redirect_to root_path
    end

    private
      def login(user)
        session[:user_id] = nil
      end
end
