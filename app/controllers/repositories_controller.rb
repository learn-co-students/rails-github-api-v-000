class RepositoriesController < ApplicationController
  def index
  	user = Faraday.get 'https://api.github.com/user', {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
  	@user_name = JSON.parse(user.body)["login"]
  	

  	resp = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
  	@repos = JSON.parse(resp.body)

  end

  def create
  	repo = Faraday.post "https://api.github.com/user/repos", { name: params[:name] }.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json', 'content_type' => 'application/json'}
  	puts repo.inspect
  	redirect_to root_path
  end
end
