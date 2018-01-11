class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # Authenticate user is used throughout the controllers to make sure you have a token. This will only be skipped at the session#create action so that we can create the authenticated user.
  before_action :authenticate_user

  private

    # This method will redirect back to the github authorization request access page (client ID is only parameter required) if you are not logged in. This token (if you have one) is then used in the session create to authenticate the user
    def authenticate_user
      redirect_to "https://github.com/login/oauth/authorize?client_id=#{ENV['GITHUB_CLIENT']}&scope=repo" if !logged_in?
    end

    # Being logged in just means you have received your access token and stored it in session (this method just returns truthy or falsy depending on if you have a token already stored in the session)
    def logged_in?
      !!session[:token]
    end
end