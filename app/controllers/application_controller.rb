class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user

  private

    def authenticate_user
      client_id = ENV['GITHUB_CLIENT_ID']
      redirect_uri = CGI.escape("http://localhost:3000/auth")
      state = ENV['STATE']
      request_url = "https://github.com/login/oauth/authorize?client_id=#{client_id}&redirect_uri=#{redirect_uri}&state=#{state}&&scope=repo"
      redirect_to request_url unless logged_in?
    end

    def current_user_info
      if logged_in?
        resp = Faraday.get('https://api.github.com/user') do |req|
          req.params['access_token'] = session[:token]
        end

        body = JSON.parse(resp.body)
      end
      body
    end

    def logged_in?
      !!session[:token]
    end
end
