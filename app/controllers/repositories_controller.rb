class RepositoriesController < ApplicationController
  def index
    if logged_in?
      get_username 
      get_repos
    end
  end

  def create
    resp = Faraday.post("https://api.github.com/user/repos") do |req|
      req.params['access_token'] = session[:token]
      req.body = {name: "#{params[:name]}"}.to_json
    end
    redirect_to root_path
  end

  private

  def get_username
    resp = Faraday.get("https://api.github.com/user") do |req|
      req.params['access_token'] = session[:token]
    end
    body = JSON.parse(resp.body)
    @username = body['login']
  end

  def get_repos
    resp = Faraday.get("https://api.github.com/user/repos") do |req|
      req.params['access_token'] = session[:token]
      req.params['sort'] = "created"
    end
    @repos = JSON.parse(resp.body).map{|repo| repo["name"]}
  end
end
