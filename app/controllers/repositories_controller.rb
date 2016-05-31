class RepositoriesController < ApplicationController
  def index
    user_info = Faraday.get("https://api.github.com/user") do |req|
      req.headers["Authorization"] = "token #{session[:token]}"
      req.headers["Accept"] = "application/json"
    end
    @login = JSON.parse(user_info.body)["login"]
    repo_info = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers["Authorization"] = "token #{session[:token]}"
      req.headers["Accept"] = "application/json"
    end
    @repos = JSON.parse(repo_info.body)
  end

  def create
    Faraday.post "https://api.github.com/user/repos", {name: params[:name]}.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    redirect_to root_path
  end

end
