class RepositoriesController < ApplicationController
  
  def index
  	@username = session[:username]
  	
  	repos_resp = Faraday.get "https://api.github.com/user/repos", {}, {"Authorization" => "token #{session[:token]}", "Accept" => "application/json"}
  	@repos = JSON.parse(repos_resp.body)

  end

  def create
  	binding.pry
  	# notice in this one, #to_json is being called on the value. It needs to be called on the entire hash
  	#new_repo_resp = Faraday.post "https://api.github.com/user/repos", {"name" => params[:name].to_json}, {"Authorization" => "token #{session[:token]}", "Accept" => "application/json"}
  	new_repo_resp = Faraday.post "https://api.github.com/user/repos", {"name" => params[:name]}.to_json, {"Authorization" => "token #{session[:token]}", "Accept" => "application/json"}

  	redirect_to root_path
  end

end
