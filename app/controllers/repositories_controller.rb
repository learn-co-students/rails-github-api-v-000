class RepositoriesController < ApplicationController
  def index
    repos = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/jsonN'
  end
  @repos = JSON.parse(repos.body)
  end

  def create
    repo_name = params[:name]
    create = Faraday.post("https://api.github.com/user/repos") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
      req.body = {name: repo_name}.to_json
    end
    redirect_to '/'
  end
end
