class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user
  before_action :get_username
  

  private

    def authenticate_user
      client_id = ENV['GITHUB_CLIENT']
      redirect_uri = "https://learn-javascript-dakotalmartinez.c9users.io/auth"
      state = ENV['GITHUB_STATE']
      github_url = "https://github.com/login/oauth/authorize?client_id=#{client_id}&redirect_uri=#{redirect_uri}&state=#{state}"
      redirect_to github_url unless logged_in?
    end
    
    def get_username
      if logged_in?
        if !session[:username]
          resp = Faraday.get("https://api.github.com/user") do |req|
            req.headers["Authorization"] = "token #{session[:token]}"
          end
          user = JSON.parse(resp.body)
          session[:username] = user["login"]
        end
      else
        session[:username] = nil
      end
    end

    def logged_in?
      !!session[:token]
    end
end
