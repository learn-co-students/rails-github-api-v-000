class RepositoriesController < ApplicationController
  def index

    resp = Faraday.get("https://api.github.com/user") do |req|
      req.params['oauth_token'] = session[:token]
    end
    @user_name = JSON.parse(resp.body)["login"]

    repositories_resp = Faraday.get("https://api.github.com/users/#{@user_name}/repos")
	  @repositories = JSON.parse(repositories_resp.body)

  end

  def create
    response = Faraday.post "https://api.github.com/user/repos", {name: params[:name]}.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
  	byebug
  	redirect_to root_path
  end
end
