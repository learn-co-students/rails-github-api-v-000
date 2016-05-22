class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

    def create
      response = Faraday.post github_url, github_params, {'Accept' => 'application/json'}
      note = JSON.parse(response.body)
      session[:token] = note["access_token"]

      user_response = Faraday.get github_user_url, {}, {'Authorization': auth_token, 'Accept' => 'application/json'}
      user_json = JSON.parse(user_response.body)
      session[:username] = user_json["login"]

      redirect_to root_path
    end

  private
  def github_url
    "https://github.com/login/oauth/access_token"
  end

  def github_user_url
    "https://api.github.com/user"
  end

  def github_params
    {
      client_id: ENV["GITHUB_CLIENT"],
      client_secret: ENV["GITHUB_SECRET"],
      code: params[:code]
    }
  end

  def set_session_token(note)
    session[:token] = note["access_token"]
  end

  def auth_token
    "token #{session[:token]}"
  end

end
