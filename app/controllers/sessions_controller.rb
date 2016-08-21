class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    # resp = Faraday.post("https://GITHUB.com/login/oauth/access_token") do |req|
    #   req.params = {
    #     client_id:     ENV["GITHUB_CLIENT"], 
    #     client_secret: ENV["GITHUB_SECRET"],
    #     code:          params[:code]
    #   }  
    #   req.headers =  {'Accept' => 'application/json'}
    # end
    binding.pry

    resp = Faraday.post "https://github.com/login/oauth/access_token", {client_id: ENV["GITHUB_CLIENT"], client_secret: ENV["GITHUB_SECRET"],code: params[:code]}, {'Accept' => 'application/json'}
    
    body = JSON.parse(resp.body)

    session[:token] = body["access_token"]
  end
end