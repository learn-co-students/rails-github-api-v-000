class RepositoriesController < ApplicationController

		def index
			user = Faraday.get('https://api.github.com/user') do |req|
				req.headers['Authorization'] = 'token ' + session[:token]
				req.headers['Accept'] = 'application/json'
			end

			@user_data = JSON.parse(user.body)

			repos = Faraday.get('https://api.github.com/user/repos') do |req|
				req.headers['Authorization'] = 'token ' + session[:token]
				req.headers['Accept'] = 'application/json'
			end

			@repo_data = JSON.parse(repos.body)
		end

		def create
    	response = Faraday.post "https://api.github.com/user/repos", { name: params[:name]}.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    	redirect_to '/'
  	end


end 