class RepositoriesController < ApplicationController

  def index
    @resp = Faraday.get('https://api.github.com/user/repos') do |req|
      req.params['client_id'] = ENV['CLIENT_ID']
      req.params['client_secret'] = ENV['CLIENT_SECRET']
      req.params['access_token'] = session[:token]
    end
    @body_hash = JSON.parse(@resp.body)
    render 'index'
  end

  def create
  end
end
