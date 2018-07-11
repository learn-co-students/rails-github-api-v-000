class RepositoriesController < ApplicationController
  def index
    
    resp = Faraday.get("https://api.github.com/user/repos") do |req|
      req.params['affiliation'] = 'owner'
      req.params['access_token'] = session[:token] 
    end
    
    @repos = JSON.parse(resp.body)
    @username = @repos.first['owner']['login']
  end

  def create
    resp = Faraday.post("https://api.github.com/user/repos") do |req|
      req.body = {
        'name': params['name']
      }.to_json
    end
    redirect_to root_path
  end
end
