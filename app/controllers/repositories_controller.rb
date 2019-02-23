class RepositoriesController < ApplicationController
  
  def index
  # response = Faraday.get("https://github.com/user") do |req|
  #   req.headers["Authorization"] = "token #{session[:token]}"
  # req.headers["Accept"] = "application/json"

  # end
  # body = JSON.parse(response.body)
    
  # @name = body["login"]

      resp = Faraday.get("https://github.com/user/repos") do |req|
        req.headers["Authorization"] = "token #{session[:token]}"
      req.headers["Accept"] = "application/json"
        # req.params['oauth_token'] = session[:token]
      end

      @results = JSON.parse(resp.body)  
      # ["response"]["friends"]["items"]
  end

  def create

    client_id = ENV['GITHUB_CLIENT_ID']
  
    client_secret = ENV['GITHUB_CLIENT_SECRET']

    @resp = Faraday.post 'https://api.github.com/user/repos' do |req|

      req.params['client_id'] = client_id
      req.params['client_secret'] = client_secret
    end

    body = JSON.parse(@resp.body)

    if @resp.success?
      @venues = body["response"]["venues"]
    else
      @error = body["meta"]["errorDetail"]
    end
    render 'search'

    rescue Faraday::TimeoutError
      @error = "There was a timeout. Please try again."
      render 'search'
  end


end


#  not sure.. where to go from here.