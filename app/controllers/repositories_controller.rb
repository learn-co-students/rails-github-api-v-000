class RepositoriesController < ApplicationController

  def index
    user = Faraday.get ('https://api.github.com/user') do |req|
      req.params['access_token'] = session[:token]
    end
      @repo_owner = JSON.parse(user.body)

    repos = Faraday.get  ('https://api.github.com/user/repos') do |req|
      req.params['access_token'] = session[:token]
    end
      @repo_data = JSON.parse(repos.body)

  end

  end

  # def create
  #   # resp = Faraday.post'https://api.github.com/user/repos' do |req|
  #   #   req.body
  #
  # end

# end
