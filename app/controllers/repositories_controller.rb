class RepositoriesController < ApplicationController
  def index
    response = Faraday.get("https://api.github.com/user") do |request|
      request.headers['Authorization'] = "token #{session[:token]}"
      request.headers['Accept'] = 'application/json' # tells GitHub's server that we'll accept JSON as a response
    end

    @login = JSON.parse(response.body)['login']

    resp = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
    end

    @repos_array = JSON.parse(resp.body) # @repos_array stores an array of repo hashes
  end

  def create
    Faraday.post("https://api.github.com/user/repos") do |request|
      request.body = {'name': params[:name]}.to_json
      request.headers['Authorization'] = "token #{session[:token]}"
      request.headers['Accept'] = 'application/json'
    end
    redirect_to root_url
  end
end
# repositories#create explanation:
# form in app/views/repositories/index.html.erb submits via a
# POST request to '/repositories/create', which maps to 'repositories#create'
# According to GitHub docs:
# Create a new repository for the authenticated user - POST /user/repos
# Parameter Required: name parameter, which points to the string name of the repository.
# We get the value for the string name of the repository from the
# <input type="text" name="name" id="new-repo"> text field in form,
# which is accessed as params[:name] upon form submission
# GitHub API expects POST data as well-formatted JSON text string in request body
# to_json returns a JSON string representing the hash.

# repositories#index explanation:
# Call the GitHub API from within repositories#index
# to retrieve and display the current user's login username in app/views/repositories/index.html.erb.
# From the GitHub API Documentation:
# Use the access token to access the API
# The access token allows you to make requests to the API on a behalf of a user.
# Example:
# GET https://api.github.com/user?access_token=...
# You can pass the token in the query params as shown above,
# but a cleaner approach is to include it in the Authorization header.
# Authorization: token OAUTH-TOKEN
# For example, in curl you can set the Authorization header like this:
# curl -H "Authorization: token OAUTH-TOKEN" https://api.github.com/user

# Get the authenticated user - GET /user
# "https://api.github.com/user"
# The body of our JSON response is a string, and we use JSON.parse() to parse it into a Ruby hash
# The 'login' key of this Ruby hash points to the string value of the GitHub username,
# which we store in @login variable
# hash[key] = value

# Call the API a second time using https://api.github.com/user/repos
# to retrieve and display a list of repositories on app/views/repositories/index.html.erb
# List your repositories (repositories that the authenticated user has explicit permission to access):
# GET /user/repos
