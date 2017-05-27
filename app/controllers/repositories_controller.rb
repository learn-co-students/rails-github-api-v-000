class RepositoriesController < ApplicationController
  def index
    @repositories = getRepositories
  end

  def create
    name = params[:name]
    createRepository(name)
    redirect_to root_path
  end

  def getRepositories
    resp = Faraday.get("https://api.github.com/user/repos") do |req|
        req.params['access_token'] = session[:token]
        req.headers = {Accept: 'application/json'}
    end
    
    repos = JSON.parse(resp.body)
  end

  def createRepository(name)
    body = ''
    resp = Faraday.post("https://api.github.com/user/repos") do |req|
        req.params['access_token'] = session[:token]
        req.body = '{ "name": "' + name + '"}'
        body = req.body
    end

    response = JSON.parse(resp.body)
    byebug
  end
end
