class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    resp = Faraday.get("https://github.com/login/oauth/access_token") do |req|
      req.body = { "client_id": ENV['CLIENT_ID'], "client_secret": ENV['CLIENT_SECRET'], "code": params[:code]}
      req.headers = {'Accept' => 'application/json'}
    end
    # resp = Faraday.get("https://github.com/login/oauth/access_token") do |req|
    #    req.body = {"client_id"=>nil, "client_secret"=>nil, "code"=>"20"},
    #    req.headers = {'Accept'=>'application/json'}
    #  end

  body_hash = JSON.parse(resp.body)
  session[:token] = body_hash["access_token"]

  user_resp = Faraday.get("https://api.github.com/user") do |req|
    req.headers = {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    end

  # user_resp = Faraday.get("https://api.github.com/user") do |req|
  #   req.headers = {'Authorization'=>'token 1', 'Accept' => 'application/json'}
  # end
  user_json = JSON.parse(user_resp.body)
  session[:username] = user_json["login"]

  redirect_to root_path

  end


end
