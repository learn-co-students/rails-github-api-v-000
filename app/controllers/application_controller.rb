class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user

  private

  def authenticate_user
    client_id = ENV['GITHUB_CLIENT_ID']
    redirect_uri = ENV['GITHUB_REDIRECT_URI']
    state = SecureRandom.hex(32)

    girl = github_identity_request_url = "https://github.com/login/oauth/authorize?"
    girl << "client_id=#{client_id}" << "&"
    girl << "redirect_uri=#{redirect_uri}" << "&"
    girl << "state=#{state}"

    redirect_to girl
  end

  def logged_in?
  end
end
