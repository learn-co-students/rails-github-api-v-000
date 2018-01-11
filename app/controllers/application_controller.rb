class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def authenticate_user
    client_id=ENV["GITHUB_CLIENT"]
    redirect_uri=CGI.escape("http://localhost:3000/auth")
    gh_oauth_url = "https://github.com/login/oauth/authorize?client_id=#{client_id}&scope=repo"
    redirect_to gh_oauth_url unless logged_in?
  end

    def logged_in?
      !!session[:token]
    end
end
