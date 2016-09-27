class RepositoriesController < ApplicationController
   def index
    resp = Faraday.get("https://api.github.com/user") do |req|
      req.headers['authorization'] = "token #{session[:token]}"
      req.headers['accept'] = 'application/json'
    end
    @username = JSON.parse(resp.body)["login"]

    repo_resp = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers["Authorization"] = "token #{session[:token]}"
      req.headers["Accept"] = "application/json"
    end
    @repos = JSON.parse(repo_resp.body)
   end

   def create
    new_repo = params[:name]
    new_repo_resp = Faraday.post("https://api.github.com/user/repos") do |req|
      req.headers["Authorization"] = "token #{session[:token]}"
      req.headers["Accept"] = 'application/json'
      req.body = {name: new_repo}.to_json
    end
    redirect_to root_path
   end

 end
