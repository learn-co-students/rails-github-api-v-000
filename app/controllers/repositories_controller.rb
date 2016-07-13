class RepositoriesController < ApplicationController
  def index
    repos = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    @user_repos = JSON.parse(repos.body)
    # binding.pry
  end

  def create
    repos= Faraday.post "https://api.github.com/user/repos", {name: params[:name]}.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    redirect_to root_path
  end
end
