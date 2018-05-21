class RepositoriesController < ApplicationController
  def index
    repo_list_resp = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    @repos = JSON.parse(repo_list_resp.body)
  end

  def create
    req = Faraday.post "https://api.github.com/user/repos", {'name' => params[:name]}.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    redirect_to '/'
  end
end
