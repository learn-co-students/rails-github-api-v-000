require 'json'
class RepositoriesController < ApplicationController
  def index
    username = session[:username]
    resp = Faraday.get("https://api.github.com/users/#{username}/repos") do |req| 
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = "application/json"
    end 
    @repos = JSON.parse(resp.body)
  end

  def create
    body = {name: "#{params[:name]}"}
    Faraday.post("https://api.github.com/user/repos") do |req| 
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Content-Type'] = 'application/json'
      req.body = body.to_json
    end

    redirect_to root_path
  end
end
