class RepositoriesController < ApplicationController
  def index
    resp = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers['authorization'] = "token #{session[:token]}"
      req.headers['accept'] = 'application/json'
    end
    @repos = JSON.parse(resp.body)
  end

  def create
    response = Faraday.post "https://api.github.com/user/repos", {name: params[:name]}.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    raise
    
    redirect_to root_path
  end
end


