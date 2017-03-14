class SessionsController < ApplicationController
	skip_before_action :authenticate_user, only: :create
	# otherwise we'd have a snake loop of death and despair

	def create
		# we're sent here by the GET '/auth' => 'sessions#create' route
		# response = Faraday.post("https://github.com/login/oauth/access_token") do |request|
		# 	request.headers['Accept'] = 'application/json'
		# 	request.body = JSON.generate({
		# 			'client_id': ENV["GITHUB_CLIENT_ID"],
		# 			'client_secret': ENV["GITHUB_CLIENT_SECRET"],
		# 			'code': params[:code]
		# 		})
		# end
		# could also be written 
		response = Faraday.post "https://github.com/login/oauth/access_token", {client_id: ENV["GITHUB_CLIENT_ID"], client_secret: ENV["GITHUB_CLIENT_SECRET"],code: params[:code]}, {'Accept' => 'application/json'}

		# this is sent back by github under the following form by default
		# access_token=e72e16c7e42f292c6912e7710c838347ae178b4a&scope=user%2Cgist&token_type=bearer
		# and since we asked for headers "Accept: application/json"
		# {"access_token":"e72e16c7e42f292c6912e7710c838347ae178b4a", "scope":"repo,gist", "token_type":"bearer"}
		access_hash = JSON.parse(response.body)
		session[:token] = access_hash["access_token"]

		##### Now we have the token and we can use it to access the API

		# we make a call to get the username
		user_response = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
		# parse the response body
		user_json = JSON.parse(user_response.body)
		# set the username into the session
		session[:username] = user_json["login"]
		binding.pry
		# next step happens in the root path (repositories#index)
		redirect_to root_path
	end
end