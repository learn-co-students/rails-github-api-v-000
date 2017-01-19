class RepositoriesController < ApplicationController
  def index
  	@username = current_user
  	
  	resp = Faraday.get("https://api.github.com/user/repos") do |req|
  		req.headers['Authorization'] = "token #{session[:token]}" 
  	end
  	@repos = JSON.parse(resp.body)

  end

  def create
  	resp = Faraday.post("https://api.github.com/user/repos") do |req|
  		req.body = { "name" => params[:name] }.to_json
  		req.headers['Accept'] = 'application/json'
  		req.headers['Authorization'] = "token #{session[:token]}" 
  	end
  	puts resp.body
  	redirect_to root_path
  end
end
