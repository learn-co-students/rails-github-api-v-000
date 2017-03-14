class RepositoriesController < ApplicationController
  def index
  	# we have been redirected after successful authentication
  	# we can only use the token from now on
  	response = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
  	@repos_array = JSON.parse(response.body)
  end

  def create
  	response = Faraday.post "https://api.github.com/user/repos", {name: params[:name]}.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
  	redirect_to '/'
  end
end
