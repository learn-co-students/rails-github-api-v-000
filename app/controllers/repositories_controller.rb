class RepositoriesController < ApplicationController
  before_action :authenticate_user

  def index
    # resp = Faraday.get("https://api.github.com/user/repos") do |req|
    #   req.params['oauth_token'] = session[:token]
    # end

    response = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    # @repos_array = JSON.parse(response.body) 
    

    @results = JSON.parse(response.body)

  end

end
