class RepositoriesController < ApplicationController
  def index
    resp = Faraday.get('https://api.github.com/user/repos') do |req|
      req.headers = {
        'Accept' => 'application/json',
        'Authorization' => "token #{session[:token]}"
       }
       req.params['type'] = 'owner'
    end
    @repos = JSON.parse(resp.body)
  end

  def create
    resp = Faraday.post("https://api.github.com/user/repos") do |req|
      req.body = { "name" => params[:name] }.to_json
      req.headers = {
        'Accept' => 'application/json',
        'Authorization' => "token #{session[:token]}"
       }
    end

    # binding.pry
    redirect_to root_path
  end
end
