class RepositoriesController < ApplicationController
  def index
      resp = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
  
    @repos = JSON.parse(resp.body)
  end

  def create
      resp = Faraday.post"https://api.github.com/user/repos", {name: params[:name]}.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    redirect_to '/'
  end
end
