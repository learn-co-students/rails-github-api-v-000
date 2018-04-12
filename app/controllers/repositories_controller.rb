class RepositoriesController < ApplicationController
  def index
    # GET USERNAME
    url = 'https://api.github.com/user'
    resp = Faraday.get url do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
    end

    body = JSON.parse(resp.body)
    @username = body["login"] 

    # GET REPOSITORIES
    url2 = "https://api.github.com/user/repos"
    resp2 = Faraday.get url2 do |req| 
      req.headers['Authorization'] = "token #{session[:token]}"
    end

    @repositories = JSON.parse(resp2.body)
  end

  def create
    url = "https://api.github.com/user/repos"
    resp = Faraday.post url do |req|
      #req.body = { 'name': params[:name] }.to_json
      req.body = { "name": params[:name] }
      req.headers['Authorization'] = "token #{session[:token]}"
    end

    binding.pry
    redirect_to "/"
  end
end


#{:client_id=>"9d92edfbc117cb4626d4",
# :client_secret=>"d0ee440d0d3090004f8c513d2fb5c779bf34cf2a",
# :code=>nil}

# {:name=>"david3"}
# "{\"name\":\"david3\"}"