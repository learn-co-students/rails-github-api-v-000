class RepositoriesController < ApplicationController

  def index

    @resp = Faraday.get 'https://api.github.com/user/repos' do |req|
          # req.params['access_token'] = session[:token]
          req.headers['Authorization'] = "token " + session[:token]
          req.headers['Accept'] = "application/json"
        end
    @resp2 = Faraday.get 'https://api.github.com/user' do |req|
          # req.params['access_token'] = session[:token]
          req.headers['Authorization'] = "token " + session[:token]
          req.headers['Accept'] = "application/json"
        end

        @repos = JSON.parse(@resp.body)

        @user = JSON.parse(@resp2.body)

  end

end
