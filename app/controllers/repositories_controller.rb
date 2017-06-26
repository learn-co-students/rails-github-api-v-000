class RepositoriesController < ApplicationController
  def index
    resp = Faraday.get('https://api.github.com/user/repos') do |req|
      req.headers['Accept'] = 'application/json'
      req.params[:access_token] = session[:token]
    end
    body = JSON.parse(resp.body)
    @repos = body
  end

  def create
    resp = Faraday.post('https://api.github.com/user/repos') do |req|
      # req.headers['Content-Type'] = 'application/json'
      req.headers = {
        'Content-Type' => 'application/json',
        'Authorization' => "token #{session[:token]}"
       }
      # req.headers['token'] = session[:token]
      req.params['name'] = params[:name]
      redirect_to root_path
    end

    # Faraday.get('https://api.github.com/repos/williammena/aaabbb') do |req|
    #   req.headers['Accept'] = 'application/json'
    #   req.params[:access_token] = session[:token]
    # end


    binding.pry
  end
end
