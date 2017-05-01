class RepositoriesController < ApplicationController
  def index
    # Request the repos for the given authenticated user, just use Authentication syntax and accept header, then parse the info for JSON.
    req = Faraday.get "https://api.github.com/user/repos", {},
      {'Authorization' => "token #{session[:token]}",
       'Accept' => 'application/json'}

    @repos = JSON.parse(req.body)
  end

  def create
    # Create repo for the name given in the form, to create a repo you need to the post verb, required github url, and the repo name you want to create IN JSON. Again you need the authorization syntax and accept header.
    create_resp = Faraday.post "https://api.github.com/user/repos", 
      { name: params[:name] }.to_json, 
      {'Authorization' => "token #{session[:token]}",
       'Accept' => 'application/json'}

    redirect_to '/'
  end
end