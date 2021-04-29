class RepositoriesController < ApplicationController
  
  def index
    resp = Faraday.get("https://api.github.com/user") do |req|
      req.headers['Authorization'] = 'token ' + session[:token]
    end

    @header = resp.headers
    @login = JSON.parse(resp.body)["login"]
    response = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers['Authorization'] = 'token ' + session[:token]
      #req.params['per_page'] = 100
    end
    @repos = JSON.parse(response.body)
  end

  def create
    resp = Faraday.post("https://api.github.com/user/repos") do |req|
      req.headers['Authorization'] = 'token ' + session[:token]
      req.body = {'name': params[:name]}
    end
    redirect_to root_path
  end
end
