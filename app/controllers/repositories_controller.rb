class RepositoriesController < ApplicationController
  def index
    user_resp = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    user_data = JSON.parse(user_resp.body)
    session[:username] = user_data["login"]

    repo_list_resp = Faraday.get "https://api.github.com/users/#{session[:username]}/repos"
    @repos = JSON.parse(repo_list_resp.body)
  end

  def create
    req = Faraday.post "https://api.github.com/user/repos", {'name' => params[:name]}.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    redirect_to '/'
  end
end
