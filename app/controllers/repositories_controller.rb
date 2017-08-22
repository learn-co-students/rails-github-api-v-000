class RepositoriesController < ApplicationController
  def index
  	response = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
  	@repos_data_array = JSON.parse(response.body)
  	@username = session[:username]
  end

  def create
  	response = Faraday.post "https://api.github.com/user/repos", {name: params[:name]}.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    binding.pry
    redirect_to '/'
  end
end
