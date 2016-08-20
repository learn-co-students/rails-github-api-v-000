class RepositoriesController < ApplicationController
  def index
    resp = Faraday.get("https://api.github.com/user") do |req|
      req.headers['authorization'] = "token #{session[:token]}"
      req.headers['accept']        = 'application/json'
    end

    resp  = JSON.parse(resp.body)
    @user = resp['login']
    @url  = resp['repos_url']

    repos = Faraday.get(@url) do |req|
      req.headers['authorization'] = "token #{session[:token]}"
      req.headers['accept']        = 'application/json'
    end

    @repositories = JSON.parse(repos.body)

  end

  def create
    resp = Faraday.post("https://api.github.com/user/repos") do |req|
      req.headers['authorization'] = "token #{session[:token]}"
      req.body                     = {name: params[:name]}.to_json
    end

    @repositories = JSON.parse(resp.body)
    
    redirect_to root_path
  end
end
