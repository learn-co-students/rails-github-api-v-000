class RepositoriesController < ApplicationController

  def index
    resp = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers['Accept'] = 'application/json'
      # don't forget that pesky v param for versioning
      req.headers['Authorization'] = "token #{session[:token]}"
    end
    resp2 = Faraday.get("https://api.github.com/user") do |req|
      req.headers['Accept'] = 'application/json'
      # don't forget that pesky v param for versioning
      req.headers['Authorization'] = "token #{session[:token]}"

    end

    @repos = JSON.parse(resp.body)
    @userData = JSON.parse(resp2.body)
      #  binding.pry
  end


end
