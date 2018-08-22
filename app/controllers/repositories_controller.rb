class RepositoriesController < ApplicationController

  def index
    repo = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers = {'Accept': 'application/json', 'Authorization': "token #{session[:token]}"}
    end
    @repos = JSON.parse(repo.body)
  end

  def create
    repo_name = {'name': params[:name]}.to_json
    new_repo = Faraday.post("https://api.github.com/user/repos") do |req|
      req.body = {'name': "#{params[:name]}"}.to_json
      req.headers = {'Accept': 'application/json', 'Authorization': 'token #{session[:token]}'}
    end
    redirect_to root_path
  end

end
