class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user

  def user_name
    @user_info ||= fetch_user_info
    @user_info['name'] || @user_info['login']
  end
  helper_method :user_name

private

  def authenticate_user
    redirect_uri = CGI.escape("http://localhost:3000/auth")
    github_url = "https://github.com/login/oauth/authorize?client_id=#{ENV['GITHUB_CLIENT_ID']}&redirect_uri=#{redirect_uri}"
    redirect_to github_url unless logged_in?
  end

  def fetch_user_info
    resp = Faraday.get("https://api.github.com/user") do |req|
      req.headers['Accept'] = 'application/json'
      req.headers['Authorization'] = "token #{session[:token]}"
    end
    @user_info = JSON.parse(resp.body)
  end

  def logged_in?
    !!session[:token]
  end

end
