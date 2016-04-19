class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    response = Faraday.post "https://github.com/login/oauth/access_token", {client_id: ENV["GITHUB_CLIENT"], client_secret: ENV["GITHUB_SECRET"],code: params[:code]}, {'Accept' => 'application/json'}
    access_hash = JSON.parse(response.body)
    session[:token] = access_hash["access_token"]

    user_response = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    user_json = JSON.parse(user_response.body)
    session[:username] = user_json["login"]

    redirect_to '/'

    # resp = Faraday.get("https://github.com/login/oauth/access_token") do |req|
    #   req.params['client_id'] = ENV['GITHUB_CLIENT_ID']
    #   req.params['client_secret'] = ENV['GITHUB_CLIENT_ID']
    #   req.params['code'] = params[:code]
    #   req.params['redirect_uri'] = "http://localhost:3000/auth"
    # end

    # session[:token] = resp.body #not sure about this
    # redirect_to root_path

  end

  def destroy
    session.clear
    binding.pry
    redirect_to root_path
  end
end

  # def create
  #   resp = Faraday.get("https://foursquare.com/oauth2/access_token") do |req|
  #     req.params['client_id'] = ENV['FOURSQUARE_CLIENT_ID']
  #     req.params['client_secret'] = ENV['FOURSQUARE_SECRET']
  #     req.params['grant_type'] = 'authorization_code'
  #     req.params['redirect_uri'] = "http://localhost:3000/auth"
  #     req.params['code'] = params[:code]
  #   end

  #   body = JSON.parse(resp.body)
  #   session[:token] = body["access_token"]
  #   redirect_to root_path
  # end