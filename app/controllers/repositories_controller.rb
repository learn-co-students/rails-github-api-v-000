class RepositoriesController < ApplicationController
  #Call the GitHub API from within repositories#index 
  #to retrieve and display the current user's 'login' 
  #in repositories/index.html.erb.
  def index
    response = Faraday.get "https://api.github.com/user/repos" do  |req|
      req.headers['Accept'] = 'application/json'
      req.headers['Authorization'] = "token #{session[:token]}"
    end
      @repos = JSON.parse(response.body)
  end

end
