class RepositoriesController < ApplicationController

  def index
      user = Faraday.get('https://api.github.com/user') do |req|
        req.headers['Authorization'] = 'token ' + session[:token]
        req.headers['Accept'] = 'application/json'
      end

      @username = JSON.parse(user.body)['login']

      resp = Faraday.get('https://api.github.com/user/repos') do |req|
        req.headers['Authorization'] = 'token ' + session[:token]
        req.headers['Accept'] = 'application/json'
      end

      @repos = JSON.parse(resp.body)
  end

  def create
    resp = Faraday.post('https://api.github.com/user/repos') do |req|
      req.headers['Authorization'] = 'token ' + session[:token]
      req.headers['Accept'] = 'application/json'
      req.body = { 'name': params[:name] }.to_json
    end
    redirect_to '/'
  end

end
