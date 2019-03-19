class RepositoriesController < ApplicationController

  def index
    resp_user = Faraday.get("https://api.github.com/user") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
    end
    @login = JSON.parse(resp_user.body)['login']

    resp_user_repos = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
      
    end
    @repos = JSON.parse(resp_user_repos.body)
  end

  def create
    resp = Faraday.post("https://api.github.com/user/repos") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
      req.body = { 'name': params['name'] }
    end
    raise resp.inspect
    redirect_to root_path
  end

end
