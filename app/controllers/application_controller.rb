class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user
  private

    def authenticate_user
      client_id = ENV['GITHUB_CLIENT']
      redirect_uri = CGI.escape("http://localhost:3000/auth")
      github_url = "http://github.com/login/oauth/authorize?client_id=#{client_id}&redirect_uri=#{redirect_uri}"
      get_user_info
      redirect_to github_url unless logged_in?
    end

    def logged_in?
      !!session[:token]
    end

    def get_user_info
      resp = Faraday.get('https://api.github.com/user') do |req|
        req.headers['Accept'] = 'application/json'
        req.params['access_token'] = session[:token]
      end
      body = JSON.parse(resp.body)
      @username = body['login']
    end
end
