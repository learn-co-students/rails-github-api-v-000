class RepositoriesController < ApplicationController
  def index
    user = session[:username]
    resp = Faraday.get "https://api.github.com/users/#{user}/repos"
    body = JSON.parse(resp.body)
    @repos = body
  end

  def create
    response = Faraday.post "https://api.github.com/user/repos", {name: params[:name]}.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    redirect_to '/'
  end
end
