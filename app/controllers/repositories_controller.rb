class RepositoriesController < ApplicationController

  def index
    user = Faraday.get("https://api.github.com/user") do |req|
      req.headers["Authorization"] = "token #{session[:token]}"
    end
    @body = JSON.parse(user.body)

    repositories = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers["Authorization"] = "token #{session[:token]}"
    end
    @repos = JSON.parse(repositories.body)
  end

end
