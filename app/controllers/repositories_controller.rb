class RepositoriesController < ApplicationController

  def index
    # resp = Faraday.get("https://api.github.com/user") do |req|
    #   req.params['oauth_token'] = session[:token]
    # end

    resp = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    @user = JSON.parse(resp.body)

    response = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    @repos = JSON.parse(response.body)

  end

end
