class RepositoriesController < ApplicationController

  def index
    # username
    user_resp = Faraday.get('https://api.github.com/user', {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'})
    # user_resp = Faraday.get('https://api.github.com/user', nil, {'Authorization'=>'token 1'})
    user_body = JSON.parse(user_resp.body)
    # binding.pry


    # repos
    repo_resp = Faraday.get("https://api.github.com/user/repos", nil, {'Authorization'=> "token #{session[:token]}"})
    @repositories = JSON.parse(repo_resp.body)
  end

  def create
    resp = Faraday.post("https://api.github.com/user/repos", {name: params[:name]}.to_json, {'Authorization' => "token #{session[:token]}"})
    redirect_to root_path
  end

end
