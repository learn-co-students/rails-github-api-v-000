class RepositoriesController < ApplicationController
  
  def index
    repos = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers["Authorization"] = "token" + session[:token]
      req.headers["Accept"] = 'application/json'
    end

    @repos = JSON.parse(repos.body)

    auth_user = Faraday.get("https://api.github.com/user") do |req|
      req.headers["Authorization"] = "token" + session[:token]
      req.headers["Accept"] = 'application/json'
    end

    user_hash = JSON.parse(auth_user.body)
    @user = user_hash["login"]
  end
end
