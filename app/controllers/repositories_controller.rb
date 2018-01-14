class RepositoriesController < ApplicationController

  def index
    resp = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = "application/json"
    end
    body = JSON.parse(resp.body)
    @repos = body
  end

  def create
    Faraday.post ("https://api.github.com/user/repos") do |req|
      req.headers = {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
      req.body = {name: params[:name]}.to_json
    end
    redirect_to root_path
  end
end
