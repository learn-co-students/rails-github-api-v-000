
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user

  private
  # https://github.com/login/oauth/authorize
  #       ?client_id=YOUR_CLIENT_ID
  #       &scope=repo
  #       &state=STATE
  def authenticate_user
    client_id = ENV['GITHUB_CLIENT']
    redirect_uri = CGI.escape("https://138cfbfb445f44178c2feae6b951c939.vfs.cloud9.us-east-2.amazonaws.com/auth")
    state = ENV['GITHUB_STATE_CODE']
    github_url = "https://github.com/login/oauth/authorize?client_id=#{client_id}&redirect_uri=#{redirect_uri}&scope=repo&state=#{state}"

    redirect_to github_url unless logged_in?
  end

  def logged_in?
    !!session[:token]
  end
end
