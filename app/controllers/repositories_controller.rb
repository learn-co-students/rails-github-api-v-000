class RepositoriesController < ApplicationController
  
  def index
    response = Faraday.get("https://api.github.com/user/repos?page=1") do |faraday|
      faraday.params['access_token'] = session[:token] 
      faraday.headers['Accept'] = 'application/json'  
    end
    @repos = JSON.parse(response.body)
  end

end
