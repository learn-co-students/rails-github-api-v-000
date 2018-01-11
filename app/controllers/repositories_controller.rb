class RepositoriesController < ApplicationController
  def index
    repo_response = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers = {Authorization: "token #{session[:token]}"}
    end
    @repos = JSON.parse(repo_response.body)

    user_response = Faraday.get("https://api.github.com/user") do |req|
      req.headers = {Authorization: "token #{session[:token]}"}
    end
    user_body = JSON.parse(user_response.body)
    @username = user_body["login"]
  end

  def create
    response = Faraday.post("https://api.github.com/user/repos") do |req|
      req.headers = {Authorization: "token #{session[:token]}"}
      req.body = {name: params[:name]}.to_json
    end
    redirect_to root_path
  end
end
