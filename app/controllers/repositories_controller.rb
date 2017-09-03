class RepositoriesController < ApplicationController
  def index
  	@login = session['username']
  	repositories_resp = Faraday.get("https://api.github.com/users/#{session['username']}/repos",
						  		{},
						  		{'Authorization' => "token #{session['token']}", 'Accept' => 'application/json' })
  	repos_json = JSON.parse(repositories_resp.body)
  	@repositories = repos_json[0..20]
  end

  def create
  	response = Faraday.post("https://api.github.com/user/repos", 
				  		{name: params[:name]}.to_json,
				  		{'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json' })
    binding.pry
    @new_repo = JSON.parse(response.body)
    # {"message"=>"Not Found", "documentation_url"=>"https://developer.github.com/v3"}
    puts @new_repo

  	redirect_to '/'	
  end
end
