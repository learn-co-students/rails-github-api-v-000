class RepositoriesController < ApplicationController

  def index
   	resp = Faraday.get("https://api.github.com/user") do |req|
  	  req.headers['Authorization'] = 'token ' + session[:token]
  	  req.headers['Accept'] = 'application/json'
   	end
	  @user = JSON.parse(resp.body)["login"]

   	response = Faraday.get("https://api.github.com/user/repos") do |req|
  	   req.headers['Authorization'] = 'token ' + session[:token]
  	    req.headers['Accept'] = 'application/json'
  	end
	  @repositories = JSON.parse(response.body)
  end

end
