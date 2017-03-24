class RepositoriesController < ApplicationController
  def index

    # List your repositories (accessible to the authenticated user).
      # GET /user/repos
      # shows my repos within the 'learn-co-students' org
  response = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    

# List user repositories(public repositories for the specified user).
# shows all of my public repos, including any that I just created using the form in this lab
# fails the tests because of  WebMock::NetConnectNotAllowedError
# uses this url:                          GET /users/:username/repos
# response = Faraday.get "https://api.github.com/users/#{session[:username]}/repos", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}

    @repos = JSON.parse(response.body)
  end

  def create
    # response = Faraday.post "https://api.github.com/user/repos", {name: params[:name]}.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    response = Faraday.post "https://api.github.com/user/repos", {name: params[:name]}.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}  
    redirect_to '/'
  end
end