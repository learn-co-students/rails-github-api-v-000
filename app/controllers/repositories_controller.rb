class RepositoriesController < ApplicationController
  
  def index
    # sort = "created"
    # resp = Faraday.get "https://api.github.com/user/repos", {sort: sort}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    resp = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    @repos = JSON.parse(resp.body)
    
  end

  def create
    resp = Faraday.post "https://api.github.com/user/repos", {name: params[:name]}.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    redirect_to root_path
  end
end

# "access_token":"e72e16c7e42f292c6912e7710c838347ae178b4a", "scope":"repo,gist", "token_type":"bearer"