class RepositoriesController < ApplicationController
  def index
  	if logged_in?
		@user = current_user
		repos_response  = Faraday.get('https://api.github.com/user/repos') do |req|
          req.params['access_token'] = session[:token]
    	end
    	repos_json = JSON.parse(repos_response.body)
    	@repo_names = repos_json.collect{|repo| repo['name']}
	end
  end

  def create
  end
end
