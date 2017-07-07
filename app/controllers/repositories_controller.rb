class RepositoriesController < ApplicationController
  before_action :authenticate_user
  
  def index
    
    repo_resp = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
    end
  
    @repos = JSON.parse(repo_resp.body)
  end

  def create
    Faraday.post "https://api.github.com/user/repos", {name: params[:name]}.to_json, {Authorization: "token #{session[:token]}", Accept: 'application/json'}
    
    redirect_to root_path
  end
end
