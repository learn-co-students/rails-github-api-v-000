class RepositoriesController < ApplicationController
  
  def index
    begin

        user_resp = Faraday.get 'https://api.github.com/user' do |req|
            req.headers['Authorization'] = "token " + session[:token]
            req.headers['Accept'] = 'application/json'
        end
        @user = JSON.parse(user_resp.body)

        repos_resp = Faraday.get 'https://api.github.com/user/repos' do |req|
            req.headers['Authorization'] = 'token ' + session[:token]
            req.headers['Accept'] = 'application/json'
          end
        @repos = JSON.parse(repos_resp.body)

    rescue Faraday::TimeoutError, Faraday::ConnectionFailed
      @error = "There was a network problem. Please try again."
    end
  end
  def create
    byebug
  end

end
