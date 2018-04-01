class RepositoriesController < ApplicationController
  def index
    resp = Faraday.get("https://api.github.com/user") do |req|
      req.params['access_token'] = session[:token]
    end
    @user_name = JSON.parse(resp.body)["login"]

    repo_response = Faraday.get("https://api.github.com/user/repos") do |req|
      req.params['access_token'] = session[:token]
      req.params['sort'] = 'created'
    end
    @repos = JSON.parse(repo_response.body)
  end

  def create
    Faraday.post("https://api.github.com/user/repos") do |req|
     req.params['access_token'] = session[:token]
     req.body = '{"name": "' + params[:name] + '"}'
    end
    redirect_to root_path
  end
end
