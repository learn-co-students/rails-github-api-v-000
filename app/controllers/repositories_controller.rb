class RepositoriesController < ApplicationController

  def index
    user = Faraday.get('https://api.github.com/user') do |req|
      #the req.params worked in the browser also (instead of req.headers)
      # req.params['access_token'] = session[:token]

      req.headers['Authorization'] = 'token ' + session[:token]
      req.headers['Accept'] = 'application/json'
      binding.pry
    end
      @repo_owner = JSON.parse(user.body)

    repos = Faraday.get('https://api.github.com/user/repos') do |req|
      #the req.params worked in the browser also (instead of req.headers)
      # req.params['access_token'] = session[:token]

      req.headers['Authorization'] = 'token ' + session[:token]
      req.headers['Accept'] = 'application/json'
    end
      @repo_data = JSON.parse(repos.body)
  end

  #not sure if create method working, can't find created repos in my account
  def create
    resp = Faraday.post('https://api.github.com/user/repos') do |req|
        req.body = {'name': params[:name]}.to_json
        req.headers['Authorization'] = 'token ' + session[:token]
        req.headers['Accept'] = 'application/json'
    end
    redirect_to '/'
  end

end
