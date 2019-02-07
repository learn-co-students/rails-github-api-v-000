class RepositoriesController < ApplicationController

# Call the GitHub API from within repositories#index to retrieve and display the
# current user's 'login' in repositories/index.html.erb.
  def index
    user =
    Faraday.get("https://api.github.com/user") do |req|
      req.headers['Authorization'] = 'token ' + session[:token]
      req.headers['Accept'] = 'application/json'
    end
    @user_info = JSON.parse(user.body)

    resp =
    Faraday.get("https://api.github.com/user/repos") do |req|

      req.headers['Authorization'] = 'token ' + session[:token]
      req.headers['Accept'] = 'application/json'
    end
    @repos_info = JSON.parse(resp.body)



  end

end
