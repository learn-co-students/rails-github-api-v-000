class RepositoriesController < ApplicationController
  
  def index
    user = Faraday.get "https://api.github.com/user" do |req|
      # req.body = { 'client_id': ENV['GITHUB_CLIENT_ID'], 'client_secret': ENV['GITHUB_CLIENT_SECRET']}
      # req.headers['Accept'] = 'application/json'
      req.headers = {
        'Authorization'=>'token 1'
        }
    end
    repos = Faraday.get "https://api.github.com/user/repos" do |req|
      req.body = {"{\"name\":\"a-new-repo\"}"=>true},
      req.headers = {
      'Authorization'=>'token 1'
      }
    end
    @user = JSON.parse(user.body)
    @repos = JSON.parse(repos.body)
  end

end
