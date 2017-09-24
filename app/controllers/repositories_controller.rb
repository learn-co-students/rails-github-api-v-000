class RepositoriesController < ApplicationController
  before_action :authenticate_user 

  def reset_session
      session[:token] = nil
  end
  def index
      oauth_token = session[:token]
      @resp = Faraday.get("https://api.github.com/user/repos") do |req|
        req.headers['Accept'] = 'application/vnd.github.v3+json'
        # req.params['access_token'] = session[:token]
        req.headers['Authorization'] = "token #{oauth_token}"
      end
      body = JSON.parse(@resp.body)
      # name = body["login"] 
      # @resp2 = Faraday.get("https://api.github.com/users/" + name + "/repos") do |req|
      #     req.params['page'] = '2'
      #     req.params['per_page'] = '10'
      # end
      # body2 = JSON.parse(@resp2.body)
      @repos = body
      # reset_session
      @set = session[:token]
  end
  
  def create
  end
end
