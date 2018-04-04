class RepositoriesController < ApplicationController
  def index
    resp = Faraday.get "https://api.github.com/user?access_token=270804b98a022f51425a17110c07931a399bbc2d"
    user_info = JSON.parse(resp.body)
    @repos = JSON.parse((Faraday.get "#{user_info['repos_url']}").body)
    binding.pry
  end

  def create
    Faraday.post "https://api.github.com/user/repos", {name: params[:name]}.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    redirect_to '/'
  end
end
