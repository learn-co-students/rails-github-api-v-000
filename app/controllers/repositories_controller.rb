class RepositoriesController < ApplicationController

  def index
    user = Faraday.get("https://api.github.com/user") do |req|
      req.headers["Accept"] = 'application/json'
      req.headers["Authorization"] = `token #{session[:token]}`
    end
    @user_info = JSON.parse(user.body)
    repositories = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers["Accept"] = 'application/json'
      req.headers["Authorization"] = `token #{session[:token]}`
    end
    @repos = JSON.parse(repositories.body)
  end

end
