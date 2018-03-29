class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    response = Faraday.post "https://github.com/login/oauth/access_token", {client_id: ENV["GITHUB_CLIENT"], client_secret: ENV["GITHUB_SECRET"],code: params[:code]}, {'Accept' => 'application/json'}
    access_hash = JSON.parse(response.body)
    session[:token] = access_hash["access_token"]

    user_response = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    user_json = JSON.parse(user_response.body)
    session[:username] = user_json["login"]

    redirect_to '/'
  end


  # def create
  #   resp = Faraday.post "https://github.com/login/oauth/access_token" do |req|
  #     req.params['client_id'] = ENV['GITHUB_ID']
  #     req.params['client_secret'] = ENV['GITHUB_SECRET']
  #     req.params['code'] = params[:code]
  #     req.headers['Accept'] = 'application/json'
  #   end
  #   body = JSON.parse(resp.body)
  #   session[:token] = body["access_token"]
  #
  #   resp2 = Faraday.get("https://api.github.com/user") do |req|
  #     req.params['access_token'] = session[:token]
  #     req.headers['Accept'] = 'application/json'
  #   end
  #   body2 = JSON.parse(resp2.body)
  #   session[:username] = body2["login"]
  #
  #   redirect_to '/'
  # end

end
