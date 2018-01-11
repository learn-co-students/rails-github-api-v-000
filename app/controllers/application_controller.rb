class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user
  # will make sure that whatever we do (execept the skip_before_action in the SessionsController) we get authenticated first and foremost

  private

    def authenticate_user
    	# parameters taken from https://developer.github.com/v3/oauth/

    	client_id = ENV["GITHUB_CLIENT_ID"]   # Required. The client ID you received from GitHub when you registered.
    	# redirect_uri = CGI.escape("http://localhost:3000/auth")     # The URL in your application where users will be sent after authorization.
    	# already set up in the github admin as "http://localhost:3000/auth" we don't need to put a redirect_uri in the url
    	github_url = "https://github.com/login/oauth/authorize?client_id=#{client_id}"
    	# the action to take when this method is triggered by the before_action (unless user logged in already)
    	redirect_to github_url unless logged_in?
    	# now the next step will happen at the method called by redirect_uri (sessions_create as indicated in the route)
    end

    def logged_in?
    	!!session[:token]
    end
end
