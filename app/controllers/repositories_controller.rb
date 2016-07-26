class RepositoriesController < ApplicationController
  def index
       user_resp = Faraday.get("https://api.github.com/user") do |req|
      req.headers['authorization'] = "token #{session[:token]}"
      req.headers['accept'] = 'application/json'
    end

    @username = JSON.parse(user_resp.body)["login"]

    repo_resp = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers['authorization'] = "token #{session[:token]}"
      req.headers['accept'] = 'application/json'
    end
    @repos = JSON.parse(repo_resp.body)
  end

  def create
        new_repo_resp = Faraday.post("https://api.github.com/user/repos") do |req|
      req.headers = {Authorization: "token #{session[:token]}"}
      req.body = {name: "#{params[:name]}"}.to_json
    end

    redirect_to root_path
  end
end
