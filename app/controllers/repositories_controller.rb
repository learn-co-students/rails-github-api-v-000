class RepositoriesController < ApplicationController
  def index
    @user = session[:username]    
    res = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    @repositories = JSON.parse(res.body)

  end

  def create
    Faraday.post "https://api.github.com/user/repos", {name: params[:name]}.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    redirect_to root_path
  end
end
