class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

    def authenticate_user
      if !logged_in
        redirect_to "https://github.com/login/oauth/authorize?client_id=#{ENV['GITHUB_CLIENT']}&scope=repo"
      end
    end

    def logged_in?
       !!session[:token]
    end
end

# 537f95747ff12353026b
#
# 69697b1a57bd07678ba8abb2e86982c791be9ec9
