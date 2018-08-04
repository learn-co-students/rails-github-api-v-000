class RepositoriesController < ApplicationController
  def index
    resp = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers['Accept'] = 'application/json'
      req.headers['Authorization'] = 'token ' + session[:token]
    end

    @repos_array = JSON.parse(resp.body)

  end


  def create
  #   resp = Faraday.post("https://api.github.com/user/repos") do |req|
  #     req.params['oauth_token'] = session[:token]
  #     req.params['scope'] = repo
  #     req.params['name'] = params[:name]
  # end
  # @respos = JSON.parse(resp.body)["response"]["friends"]["items"]

  response = Faraday.post "https://api.github.com/user/repos", {name: params[:name]}.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
   redirect_to root_path
 end

end
