class RepositoriesController < ApplicationController

  def index
    begin
    @resp = Faraday.get 'https://api.github.com/user/repos' do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
    end
    body = JSON.parse(@resp.body)
    if @resp.success?
      @repos = body
    else
      @error = body["message"]
    end
    rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again."
    end
  end

  def create
    Faraday.post("https://api.github.com/user/repos") do |req|
      req.body = { name: params[:name] }.to_json
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
    end
    redirect_to '/'
  end

  def github_search
    begin
    @resp = Faraday.get 'https://api.github.com/user/repos' do |req|
      req.params['client_id'] = ENV['GITHUB_CLIENT_ID']
      req.params['client_secret'] = ENV['GITHUB_CLIENT_SECRET']
    end
    body = JSON.parse(@resp.body)
    if @resp.success?
      @repos = body["items"]
    else
      @error = body["message"]
    end

    rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again."
    end
    render 'index'
  end

end
