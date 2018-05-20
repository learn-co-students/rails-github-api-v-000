class RepositoriesController < ApplicationController

  def index
    page = "?page=#{params[:page]}"
    user_resp = Faraday.get("https://api.github.com/user") do |req|
      req.headers = {"Authorization": "token #{session[:token]}", "Accept": "application/json"}
    end

    repos_resp = Faraday.get("https://api.github.com/user/repos#{page}") do |req|
      req.headers = {"Authorization": "token #{session[:token]}", "Accept": "application/json"}
      req.body = {"page": '2'}
    end

    @username = JSON.parse(user_resp.body)['login']
    @repos = JSON.parse(repos_resp.body)
    @links = repos_resp.headers['link']
  end

  def create

    resp = Faraday.post("https://api.github.com/user/repos") do |req|
      req.headers = {"Authorization": "token #{session[:token]}", "Accept": "application/json"}
      req.body = {'name': params[:name]}.to_json
    end

    redirect_to root_path
  end
end
