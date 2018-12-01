class RepositoriesController < ApplicationController

  def index
    user = Faraday.get 'https://api.github.com/user' do |req|
      req.headers['Authorization'] = 'token ' + session[:token]
      req.headers['Accept'] = 'application/json'
    end

    # We use this as a global variable so we can use it on the view page
    @user_data = JSON.parse(user.body)

    repos = Faraday.get 'https://api.github.com/user/repos' do |req|
      # Faraday accesses the user's information from the above endpoint
      # Below, we're setting values to the specific parameters of the req we get back
      # I'm not a hundred percent confident where to find the requirements to call the API?
      req.headers['Authorization'] = 'token ' + session[:token]
      req.headers['Accept'] = 'application/json'
    end

    @repo_data = JSON.parse(repos.body)
  end

  def create
   response = Faraday.post 'https://api.github.com/user/repos' do |req|
     req.body = { 'name': params[:name] }.to_json
     req.headers['Authorization'] = 'token ' + session[:token]
     req.headers['Accept'] = 'application/json'
   end
   redirect_to '/'
 end

end
