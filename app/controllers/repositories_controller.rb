class RepositoriesController < ApplicationController

  def index
  	user_id_request = Faraday.get("https://api.github.com/user?" + session[:token])
  	username = JSON.parse(user_id_request.body)["login"]

  	repos_response = Faraday.get("https://api.github.com/users/#{username}/repos") do |req|
  	req['access_token'] = session[:token]
    end
    parsed_repos = JSON.parse(repos_response.body)
    @repo_names = parsed_repos.map{|r|r["name"]}
  end

  def create
  	user_id_request = Faraday.get("https://api.github.com/user?" + session[:token])
  	username = JSON.parse(user_id_request.body)["login"]

  	new_repo_name = params[:name]

  	create_repo_response = Faraday.post("https://api.github.com/user/repos") do |req|
  	req.headers['Authorization'] = "token 273ace23a91e5a6a7f96668b65d9ab49eac036b7"
  	req.headers['Content-Type'] = 'application/json'

  	req.body = '{ "name": "' + new_repo_name + '" }'
    end
    redirect_to root_path
  end

end
