class RepositoriesController < ApplicationController  
  
  def index
    resp = Faraday.get('https://api.github.com/user/repos') do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
    end
    @repos = JSON.parse(resp.body)
    user_resp = Faraday.get('https://api.github.com/user') do |req|
      req.headers['Authorization'] ="token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
    end
    user_hash = JSON.parse(user_resp.body)
    session[:username] = user_hash['login']
  end

end