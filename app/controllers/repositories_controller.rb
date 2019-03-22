class RepositoriesController < ApplicationController









  def index
    token = session[:token]
    # @resp = Faraday.get 'https://api.github.com/user' do |req|
    #   req.params['client_id'] = ENV['GITHUB_CLIENT_ID']
    #   req.params['client_secret'] = ENV['GITHUB_CLIENT_SECRET']
    #   req.params['access_token'] = token
    # end

    @resp = Faraday.get "https://api.github.com/user/repos", {},
     {'Authorization' => "token #{session[:token]}",
    'Accept' => 'application/json'}

    body_hash = JSON.parse(@resp.body)

    @login = body_hash[0]["owner"]["login"]


  @resp2 = Faraday.get 'https://api.github.com/user/repos' do |req|
        req.params['client_id'] = ENV['GITHUB_CLIENT_ID']
        req.params['client_secret'] = ENV['GITHUB_CLIENT_SECRET']
        req.params['access_token'] = token
      end
      body_hash2 = JSON.parse(@resp2.body)
      @repo = body_hash2
end
end
