class RepositoriesController < ApplicationController
  def index
    repos = Faraday.get("https://api.github.com/user/repos") do |req|
      req.params["access_token"] = session[:token]
  end
  user = Faraday.get("https://api.github.com/user") do |req|
    req.params["access_token"] = session[:token]
  end
  @user = JSON.parse(user.body)["login"]
  @repos = JSON.parse(repos.body)
  end

  def create
  end
end
