class RepositoriesController < ApplicationController
	
  def index
  	
  	@repos_response = Faraday.get "https://api.github.com/user/repos" do |req|
		req.params['oauth_token'] = session[:token]
	end

	if @repos_response.success?
		@repos = JSON.parse(@repos_response.body)
	else
		@error = body["meta"]["errorDetail"]
	end
	
  end

  def create
  	
  end

end
