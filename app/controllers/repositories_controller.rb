class RepositoriesController < ApplicationController
  
  def index
  	resp = Faraday.get("https://api.github.com/user") do |req|
  		req.headers['Authorization'] = "token #{session[:token]}"
  	end
  	@username = JSON.parse(resp.body)["login"]

  	resp = Faraday.get("https://api.github.com/user/repos") do |req|
  		req.headers['Authorization'] = "token #{session[:token]}"
  	end
  	@repositories = JSON.parse(resp.body)

  end

end
