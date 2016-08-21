class RepositoriesController < ApplicationController
  def index

    repos = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers['authorization'] = "token #{session[:token]}"
      req.headers['accept']        = 'application/json'
    end

    @repositories = JSON.parse(repos.body)
  end

  def create
    response = Faraday.post "https://api.github.com/user/repos", {name: params[:name]}.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    
    redirect_to '/'
  end

end
