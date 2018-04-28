class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user

  def set_username
    # resp = Faraday.get("https://api.github.com/user") do |req|
    #   req.params["access_token"] = session[:token]
    # end

    resp = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}

    body = JSON.parse(resp.body)
    session[:username] = body["login"]
  end

  def current_username
    @current_username ||= session[:username]
  end

  private

    def authenticate_user
      # make sure to pass in the scope parameter (`repo` scope should be appropriate for what we want to do) in step of the auth process!
      # https://developer.github.com/apps/building-oauth-apps/authorization-options-for-oauth-apps/#web-application-flow

      client_id = ENV['GITHUB_CLIENT_ID']
      redirect_uri = CGI.escape("http://localhost:3000/auth")
      github_url = "https://github.com/login/oauth/authorize?client_id=#{client_id}&redirect_uri=#{redirect_uri}&scope=repo"
      set_username unless current_username
      redirect_to github_url unless logged_in?
    end

    def logged_in?
      !!session[:token]
    end
end
