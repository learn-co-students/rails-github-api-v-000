class RepositoriesController < ApplicationController
  
  def index
  	user = Faraday.get 'https://api.github.com/user' do |req|
  		req.headers['Authorization'] = 'token ' + session[:token]
  		req.headers["Accept"] = 'application/json'
  	end
  	user_body = JSON.parse(user.body)
  	
  	@username = user_body['login']

  	repos = Faraday.get 'https://api.github.com/user/repos' do |req|
  		req.headers['Authorization'] = 'token ' + session[:token]
  		req.headers["Accept"] = 'application/json'
  	end

  	@repos_body = JSON.parse(repos.body)

  end

end
