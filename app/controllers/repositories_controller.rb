class RepositoriesController < ApplicationController
  def index
    resp = Faraday.get("https://api.github.com/user") do |req|
      req.headers["Authorization"] = session[:token]
    end
    body = JSON.parse(resp.body)
    @username = body['login']
    repos = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers['Authorization'] = session[:token]
    end
    @repos = JSON.parse(repos.body)
  end

  def create
    resp = Faraday.post("https://api.github.com/user/repos") do |req|
      req.body = JSON.generate({
        name: params[:name]
        })
      req.headers['Authorization'] = session[:token]
    end
    redirect_to root_path
  end
end
