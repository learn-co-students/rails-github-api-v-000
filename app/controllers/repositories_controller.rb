class RepositoriesController < ApplicationController
  
  def index
    @resp = Faraday.get 'https://api.github.com/user/repos' do |req|
      req.headers['Accept'] = 'application/json'
      req.params['access_token'] = session[:token]
      req.params['affiliation'] = 'owner'
      req.params['sort'] = 'updated'
    end 
    parsed_json = JSON.parse(@resp.body)
    if @resp.success?
      @repos = parsed_json
    else
      @error = "Something went wrong."
    end
  end

  def create
    resp = Faraday.post 'https://api.github.com/user/repos' do |req|
      req.headers['Accept'] = 'application/json'
      req.body = "{ 'access_token': #{session[:token]} }"
      req.body = "{ 'name': #{params[:name]} }"
      req.body = "{ 'private': false }"
      req.body = "{ 'auto_init': true }"
    end 
    redirect_to root_path
  end

end
