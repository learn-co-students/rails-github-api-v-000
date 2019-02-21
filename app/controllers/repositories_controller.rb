require 'pry'

class RepositoriesController < ApplicationController

  def index
    user = Faraday.get("https://api.github.com/user") do |req|
      #req.params['oauth_token'] = session[:token]
      req.headers["Authorization"] = 'token ' + session[:token]
      req.headers["Accept"] = 'application/json'
    end
    @user = JSON.parse(user.body)

    resp = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers["Authorization"] = 'token ' + session[:token]
      req.headers["Accept"] = 'application/json'
    end
    @repos = JSON.parse(resp.body)
  end

  def create
    name = params[:name]
    resp = Faraday.post("https://api.github.com/user/repos") do |req|
      req.body = {"name" => name}.to_json
      # req.params['name'] = params[:name]
      req.headers["Authorization"] = 'token '  + session[:token]
      req.headers["Accept"] = 'application/json'
    end
    redirect_to '/'
  end
end
