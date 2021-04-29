class RepositoriesController < ApplicationController
  def index
    resp = Faraday.get "https://api.github.com/user" do |req|
      req.headers["Authorization"] = "token #{session[:token]}"
    end

    @user = JSON.parse(resp.body)

    resp = Faraday.get "https://api.github.com/user/repos" do |req|
      req.headers["Authorization"] = "token #{session[:token]}"
    end

    @repos = JSON.parse(resp.body)
  end

  def create
    Faraday.post "https://api.github.com/user/repos" do |req|
      req.headers["Authorization"] = "token #{session[:token]}"
      req.body = {
        "name": params["name"]
      }
    end
    redirect_to root_url
  end
end
