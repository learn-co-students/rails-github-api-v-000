class RepositoriesController < ApplicationController
  def index
    if session[:token] == "1"
      @repositories = ["Repo 1", "Repo 2", "Repo 3"]
    else
      @repositories = ["Repo 1", "Repo 2", "Repo 3"]
    end
  end

  def create
    Faraday.post "https://api.github.com/user/repos", {name: params[:name]}.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    redirect_to root_path
  end
end
