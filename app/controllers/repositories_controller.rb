class RepositoriesController < ApplicationController
  def index
    user_resp = Faraday.get("https://api.github.com/user/repos") do |req|
    req.headers['accept'] = 'application/json'
    req.headers['authorization'] = "token #{session[:token]}"
    end
    @repos = JSON.parse(user_resp.body)
  end

  def create
    repo_resp = Faraday.post("https://api.github.com/user/repos") do |req|
      req.headers = { "Authorization": "token #{session[:token]}" }
      req.body = {name: params[:name]}.to_json
    end
    redirect_to root_path
  end
end
