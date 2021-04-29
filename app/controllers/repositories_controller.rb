class RepositoriesController < ApplicationController

  def index
    user = Faraday.get("https://api.github.com/user") do |req|
      req.headers = {"Authorization": "token #{session[:token]}"}
    end
    repos = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers = {"Authorization": "token #{session[:token]}"}
    end
    @user = JSON.parse(user.body)
    @repos = JSON.parse(repos.body)
  end

  def create
    resp = Faraday.post("https://api.github.com/user/repos") do |req|
      req.body = {name: params[:name]}
      req.headers = {'Accept': 'application/json', "Authorization": "token #{session[:token]}"}
    end
    redirect_to root_path
  end
end
