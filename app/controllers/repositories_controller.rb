class RepositoriesController < ApplicationController
  #Call the GitHub API from within repositories#index 
  #to retrieve and display the current user's 'login' 
  #in repositories/index.html.erb.
  def index
    "https://api.github.com/login/username"
  end

end
