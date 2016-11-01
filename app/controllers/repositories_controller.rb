class RepositoriesController < ApplicationController
  
  def index
    repos_response  = Faraday.get('https://api.github.com/user/repos') do |req|
        req['authorization'] = "token #{session[:token]}"
    end
    repos_json = JSON.parse(repos_response.body)
    @repo_names = repos_json.collect{|repo| repo['name']}
    binding.pry
  end

  def create
    if !params[:name].empty?
      # binding.pry
      conn = Faraday.new(:url => 'https://api.github.com/user/repos') do |faraday|
        faraday.response :logger                  # log requests to STDOUT
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end
      params_hash = {name: params[:name]}
      params_json = JSON.generate(params_hash)
      create_repo = conn.post do |req|
        req.headers = { Authorization: "token #{session[:token]}", Accept: 'application/json' }
        req.body = params_json
      end
      binding.pry
    end
    redirect_to root_path
  end
end
