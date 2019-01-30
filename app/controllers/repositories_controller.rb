class RepositoriesController < ApplicationController

  def index
    @resp = Faraday.get 'https://api.github.com/user/repos'  	do |req|
      # req.params['oauth_token'] = session[:token]
      req.headers['Authorization'] = 'token ' + session[:token]
        req.headers['Accept'] = 'application/json'
    end
    @body_arr = JSON.parse(@resp.body)
    user = Faraday.get 'https://api.github.com/user' do |req|
      req.headers['Authorization'] = 'token ' + session[:token]
      req.headers['Accept'] = 'application/json'
    end

    @user_data = JSON.parse(user.body)
    #
    # repos = Faraday.get 'https://api.github.com/user/repos' do |req|
    #   req.headers['Authorization'] = 'token ' + session[:token]
    #   req.headers['Accept'] = 'application/json'
    # end
    #
    # @repo_data = JSON.parse(repos.body)
  end

end
