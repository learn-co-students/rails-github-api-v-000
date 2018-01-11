class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create

    require 'pry'

    resp = Faraday.post "https://github.com/login/oauth/access_token", {"client_id"=> ENV["GITHUB_CLIENT"], "client_secret"=> ENV["GITHUB_SECRET"], "code"=>"20"}, {'Accept' => 'application/json'}
    body = JSON.parse(resp.body)
    session[:token] = body["access_token"]
    get_user = Faraday.get 'https://api.github.com/user', {}, {'Authorization': 'token 1', 'Accept': 'application/json'}
    session[:username]=JSON.parse(get_user.body)['login']
    redirect_to root_path
  end

end