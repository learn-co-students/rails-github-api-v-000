class RepositoriesController < ApplicationController
  def index
    resp = Faraday.get('https://api.github.com/user/repos') do |req|
      req.headers = {
        'Accept' => 'application/json',
        'Authorization' => "token #{session[:token]}"
       }
       req.params['type'] = 'owner'
      # req.headers['Accept'] = 'application/json'
      # req.params[:access_token] = session[:token]
    end
    @repos = JSON.parse(resp.body)
  end

  def create
    resp = Faraday.post("https://api.github.com/user/repos") do |req|
      # req.headers['Accept'] = 'application/json'
      # req.headers['Authorization'] = "token #{session[:token]}"


      # req.params['name'] = params[:name]
      # req.body = {"name":"#{params[:name]}"}
      req.body = { "name" => params[:name] }.to_json
      req.headers = {
        'Accept' => 'application/json',
        'Authorization' => "token #{session[:token]}"
       }
    end

    # Faraday.get('https://api.github.com/repos/williammena/aaabbb') do |req|
    #   req.headers['Accept'] = 'application/json'
    #   req.params[:access_token] = session[:token]
    # end
    # binding.pry
    redirect_to root_path
  end
end
