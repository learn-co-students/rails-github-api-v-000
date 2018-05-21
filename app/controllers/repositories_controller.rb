class RepositoriesController < ApplicationController
  def index
    resp = Faraday.get('https://api.github.com/user') do |req|
      req.params['access_token'] = session[:token]
    end
    @user = JSON.parse(resp.body)
    @repos = getRepos(@user['login'])
  end

  def create
    post = Faraday.post('https://api.github.com/user/repos') do |req|
      req.headers["Authorization"] = "token #{session[:token]}"
      req.body = {
        "name": "#{params[:name]}",
    }.to_json
    end
    binding.pry
    redirect_to root_path
  end

  def getRepos(login)
    url = "https://api.github.com/users/#{login}/repos"
    repoResp = JSON.parse(Faraday.get(url).body)
  end
end
