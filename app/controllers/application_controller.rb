class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user
  helper_method :current_user, :logged_in?

  private

    def authenticate_user
      client_id = ENV['GITHUB_CLIENT_ID']
      redirect_uri= CGI.escape("http://localhost:3000/auth")
      github_url = "https://github.com/login/oauth/authorize?client_id=#{client_id}&response_type=code&redirect_uri=#{redirect_uri}&scope=user%20public_repo"

      redirect_to github_url unless logged_in?
    end


    def logged_in?
      !!session[:token]
    end

    def current_user
      @current_user ||= JSON.parse(Faraday.get("https://api.github.com/user") do |req|
          req.params['oauth_token'] = session[:token]
        end.body)["login"]
    end
end
