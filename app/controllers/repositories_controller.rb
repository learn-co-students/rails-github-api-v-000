class RepositoriesController < ApplicationController

  def index
    @resp = Faraday.get "https://api.github.com/user/repos" do |req|
      req.params['Authorization'] = "token #{session[:token]}"
    end
    @data = JSON.parse(@resp.body)
  end

end
