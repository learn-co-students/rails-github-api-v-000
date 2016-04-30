class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    #  resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
    #   req.params['client_id'] = ENV['GITHUB_CLIENT']
    #   req.params['client_secret'] = ENV['GITHUB_SECRET']
    #   req.params['code'] = params[:code]
    #   req.headers['Accept'] = 'application/json'
    # end
    resp = Faraday.post "https://github.com/login/oauth/access_token", {client_id: ENV['GITHUB_CLIENT'],
      client_secret: ENV['GITHUB_SECRET'], code: params[:code]}.to_json, {'Accept' => 'application/json', 'Content-Type' => 'application/json'}
    binding.pry
    info = JSON.parse(resp.body)
    binding.pry
    session[:token] = info["access_token"]

    user_resp = Faraday.get("https://api.github.com/user") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
    end
    
    user_info = JSON.parse(user_resp.body)
    session[:username] = user_info["login"]
    #resp = Faraday.post "https://github.com/login/oauth/access_token", {client_id: ENV['GITHUB_CLIENT'], client_secret: ENV['GITHUB_SECRET'], code: params[:code]}.to_json, {'Accept' => 'application/json'}
    # binding.pry
    #session[:token] = resp.body.split('=')[1].split('&')[0]
    redirect_to root_path
  end

end

  # def create
  #   resp = Faraday.post "https://api.github.com/user/repos", {name: params[:name]}.to_json, 
  #     {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
  #   redirect_to '/'
  # end

def create
  resp = Faraday.post "https://github.com/login/oauth/access_token", {client_id: ENV['GITHUB_CLIENT'],
    client_secret: ENV['GITHUB_SECRET'], code: params[:code]}.to_json, {'Accept' => 'application/json'}
end