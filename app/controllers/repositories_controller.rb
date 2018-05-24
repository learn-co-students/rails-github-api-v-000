class RepositoriesController < ApplicationController
  def index
  	@username = session[:username]
  	resp = Faraday.get("https://api.github.com/user/repos") do |req|
  		req.headers['Authorization'] = "token #{session[:token]}"
  		req.headers['Accept'] = 'application/json'
  	end
  	@repos = JSON.parse(resp.body)
  end

  def create
  	# binding.pry
  	Faraday.post "https://api.github.com/user/repos", {name: params[:name]}.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
  	redirect_to root_path
  end
end
