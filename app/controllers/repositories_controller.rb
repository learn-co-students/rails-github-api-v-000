class RepositoriesController < ApplicationController
  def index
  	resp = Faraday.get("https://api.github.com/user/repos") do |req|
  	req.headers['Authorization'] = "token #{session[:token]}"
  	req.headers['Accept'] = 'application/json'
  end

    user_resp = Faraday.get("https://api.github.com/user") do |req|
  	req.headers['Authorization'] = "token #{session[:token]}"
  	req.headers['Accept'] = 'application/json'
  end
  	@user = JSON.parse(user_resp.body)
  	@repos = JSON.parse(resp.body)
  end

  def create
  	response = Faraday.post("https://api.github.com/user/repos") do |req|
  		req.headers['Authorization'] = "token #{session[:token]}"
  		req.body = {name: params['name']}.to_json
  	end
  	redirect_to root_path
  end
end
