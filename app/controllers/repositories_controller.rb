class RepositoriesController < ApplicationController
  def index
  	response = Faraday.get "https://api.github.com/user/repos" do |req|
  		req.headers['Accept'] = 'application/json'
			req.headers['Authorization'] = "token #{session[:token]}"
  	end
		@repos = JSON.parse(response.body)
  end

  def create
  	response = Faraday.post "https://api.github.com/user/repos" do |req|
			req.body = {name: params[:name]}.to_json
			req.headers['Accept'] = 'application/json'
			req.headers['Authorization'] = "token #{session[:token]}"
  	end
		redirect_to root_path

  end
end
