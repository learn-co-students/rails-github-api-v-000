class RepositoriesController < ApplicationController
  def index
    
    resp = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers = {'Authorization': 'token OAUTH-TOKEN'}
      req.params['affiliation'] = 'owner'
      req.params['access_token'] = session[:token] 
    end
    
    @repos = JSON.parse(resp.body)
    @username = @repos.first['owner']['login']
  end

  def create
    resp = Faraday.post("https://api.github.com/user/repos") do |req|
      req.body = {
        'client_id': ENV['CLIENT_ID'],
        'client_secret': ENV['CLIENT_SECRET'],
        'access_token': session['token'],
        'name': params['name']
      }.to_json
    end
    binding.pry
    redirect_to root_path
  end
end
