class RepositoriesController < ApplicationController
  
  def index
    resp = Faraday.get("https://api.github.com/user/repos") do |req|
      req.params['oauth_token'] = session[:token]
      req.headers['Accept'] = 'application/json'
      #req.params['v'] = '20160201'
    end

    @results = JSON.parse(resp.body)
    
  end

end
