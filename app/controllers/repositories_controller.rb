class RepositoriesController < ApplicationController
  def index
    url = "https://api.github.com/users/#{session["username"]}/repos"
    repo_search = Faraday.get(url)
    @repos = JSON.parse(repo_search.body)
  end

  def create
    resp = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    @repos = JSON.parse(resp.body)
    
    redirect_to '/'
  end
end
