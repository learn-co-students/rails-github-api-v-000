class RepositoriesController < ApplicationController

  def index
    resp = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{session[:gh_token]}", 'Accept' => 'application/json'}
# resp = Faraday.get('https://api.github.com/user/repos') do |req|
#       req['Authorization'] = "token #{session[:gh_token]}"
#       req['Accept'] = 'application/json'
#     end

    @repos_arr = JSON.parse(resp.body)
  end

  def create
    resp = Faraday.post "https://api.github.com/user/repos", {name: params[:name]}.to_json, {'Authorization' => "token #{session[:gh_token]}", 'Accept' => 'application/json'}
    redirect_to '/'
  end
end
