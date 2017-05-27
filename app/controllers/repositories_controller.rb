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
    resp = Faraday.get "https://api.github.com/user/repos", {},
      {
        Accept: 'application/json', 
        Authorization: "token #{+session[:token]}"
      }
    repos = JSON.parse(resp.body)
  end

  def createRepository(name)

    resp = Faraday.post "https://api.github.com/user/repos", 
    {name: name}.to_json, 
    {'Authorization' => "token #{session[:token]}", 
      'Accept' => 'application/json'}

  end
end
