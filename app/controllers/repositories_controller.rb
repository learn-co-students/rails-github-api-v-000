class RepositoriesController < ApplicationController
  def index
    resp = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers = { 'Accept' => 'application/json',
                      'Authorization' => "token #{session[:token]}"
      }
    end
    @repos = JSON.parse(resp.body)
  end

  def create
    Faraday.post("https://api.github.com/user/repos") do |req|
      req.headers = {
        'Accept' => 'application/json',
        'Authorization' => "token #{session[:token]}"
      }
      
      req.body = {"name": params[:name]}.to_json
    end
    
    redirect_to root_path
  end
end
