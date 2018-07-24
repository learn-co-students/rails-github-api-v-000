class RepositoriesController < ApplicationController
  def index
    resp = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers = {"Authorization": "token #{session[:token]}"}
    end
    user_resp = Faraday.get("https://api.github.com/user") do |req|
      req.headers = {"Authorization": "token #{session[:token]}"}
    end
    @user = JSON.parse(user_resp.body)["login"]
    @repos = JSON.parse(resp.body)
  end

  def create
    resp = Faraday.post("https://api.github.com/user/repos") do |req|
      req.headers = {"Authorization": "token #{session[:token]}", "Content-Type": "application/json"}
      req.body = "{\"name\": \"#{params[:name]}\"}"
      req.params[:scope] = "repo"
    end
    binding.pry
    redirect_to root_path
  end
end
