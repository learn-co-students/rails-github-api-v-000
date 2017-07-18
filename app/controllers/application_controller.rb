class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user

  private

    def authenticate_user
      client_id = ENV['GITHUB_KEY']
      redirect_url = CGI.escape('http://localhost:3000/auth')
      url = "http://github.com/login/oauth/authorize?client_id=#{client_id}&redirect_uri=#{redirect_url}&scope=repo"
      redirect_to url unless logged_in?
    end

    def logged_in?
      !!session[:token]
    end

    helper_method :current_user
    def current_user
      return @current_user if @current_user
      resp = Faraday.get "https://api.github.com/user" do |req|
        req.headers['Authorization'] = "token #{session[:token]}"
      end
      @current_user = JSON.parse(resp.body)
    end
end
