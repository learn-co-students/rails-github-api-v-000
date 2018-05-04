class RepositoriesController < ApplicationController

  def index

  	repos_resp = Faraday.get "https://api.github.com/user/repos", {}, 
	  	{'Authorization' => "token #{session[:token]}", 
	  	'Accept' => 'application/json'}

	if repos_resp.success?
		@repos = JSON.parse(repos_resp.body)
	else
		@error = body["meta"]["errorDetail"]
	end

  end

  def create

  	@repos_response = Faraday.post "https://api.github.com/user/repos", 
	  	{name: params[:name]}.to_json, 
	  	{'Authorization' => "token #{session[:token]}", 
	  	'Accept' => 'application/json'}

	redirect_to root_path

  end

end
