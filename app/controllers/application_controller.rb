class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user

  private

  def authenticate_user
    return if logged_in?

    client_id = ENV['GITHUB_CLIENT_ID']
    session[:github_state] = SecureRandom.hex(32)

    girl = github_identity_request_url = ""
    girl << "https://github.com/login/oauth/authorize?"
    girl << "client_id=#{client_id}" << "&"
    girl << "state=#{session[:github_state]}"

    redirect_to girl
  end

  def logged_in?
    !!session[:github_token]
  end
end
