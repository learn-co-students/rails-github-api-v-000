class RepositoriesController < ApplicationController
  
  def index
		resp = Faraday.get("https://api.github.com/user") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
    end
    
    body = JSON.parse(resp.body)
		@login = body["login"]

		#https://api.github.com/user/repos
		resp = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
    end
		
    body = JSON.parse(resp.body)
		@repos = body.collect do |el|
			el["name"].strip()
		end	
  end

end
