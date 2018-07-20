class RepositoriesController < ApplicationController
  
  def index
    @resp = Faraday.get 'https://api.github.com/user/repos' do |req|
      req.headers['Accept'] = 'application/json'
      req.params['access_token'] = session[:token]
      req.params['affiliation'] = 'owner'
      req.params['sort'] = 'updated'
    end 
    parsed_json = JSON.parse(@resp.body)
    if @resp.success?
      @repos = parsed_json
    else
      @error = "Something went wrong."
    end
  end

  def create
  end

end
