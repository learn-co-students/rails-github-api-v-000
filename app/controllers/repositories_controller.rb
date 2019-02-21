class RepositoriesController < ApplicationController
  # before_action :authenticate_user

  def index
    user = Faraday.get "https://api.github.com/user" do |req|

  req.headers['Accept'] = 'application/json'
  req.headers['Authorization'] = 'token ' + session[:token]
    end
  end

end
