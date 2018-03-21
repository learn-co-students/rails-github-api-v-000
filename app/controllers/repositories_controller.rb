class RepositoriesController < ApplicationController
  def index
    response = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{session[:token].to_s}", 'Accept' => 'application/json'}
    @repos = JSON.parse(response.body)
  end

  def create
    resp = Faraday.post "https://api.github.com/user/repos", {name: params[:name]}.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    # raise resp.inspect
    redirect_to root_path
  end
end
