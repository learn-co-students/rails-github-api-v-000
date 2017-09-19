class RepositoriesController < ApplicationController
  def index
  	@login = session[:username]
  	repositories_resp = Faraday.get("https://api.github.com/user/repos",
						  		{},
						  		{'Authorization' => "token #{session['token']}", 'Accept' => 'application/json' })
  	repos_json = JSON.parse(repositories_resp.body)
  	@repositories = repos_json
  end

  def create
  	response = Faraday.post("https://api.github.com/user/repos", 
				  		{name: params[:name]}.to_json,
				  		{'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json' })
  	binding.pry
    # @new_repo = JSON.parse(response.body)
  	redirect_to '/'	
  end
end
