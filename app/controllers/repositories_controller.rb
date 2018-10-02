class RepositoriesController < ApplicationController

  def index
    resp = Faraday.get("https://api.github.com/user") do |req|
      access_token = session[:token]
      req.params['access_token'] = access_token
      # req.headers['Authorization'] = 'token ' + session[:token]
      # req.headers['Accept'] = 'application/json'
    end
    @body = JSON.parse(resp.body)

    resp2 = Faraday.get("https://api.github.com/user/repos") do |req|
      access_token = session[:token]
      req.params['access_token'] = access_token
      # req.headers['Authorization'] = 'token ' + session[:token]
      # req.headers['Accept'] = 'application/json'
    end

    @repos = JSON.parse(resp2.body)
  end

  # def create
  #   response = Faraday.post 'https://api.github.com/user/repos' do |req|
  #     req.body = { 'name': params[:name] }.to_json
  #     req.headers['Authorization'] = 'token ' + session[:token]
  #     req.headers['Accept'] = 'application/json'
  #   end
  #   redirect_to '/'
  # end
end
