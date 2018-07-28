class RepositoriesController < ApplicationController
  def index
    client_id = ENV['client_id']
    client_secret = ENV['client_secret']

    @resp = Faraday.get 'https://api.github.com/user/repos' do |req|
      req.params['client_id'] = client_id
      req.params['client_secret'] = client_secret
      req.params['access_token'] = session[:token]
    end

    body = JSON.parse(@resp.body)
    # puts "BODY = #{body.length}"
    # body.each do |repo|
    #   puts "Repo = #{repo}"
    #   puts "Repo id = #{}"
    #   puts "name = #{repo['full_name']}"
    # end
    puts "USER = #{body[1]['owner']['login']}"
    @username = body[1]['owner']['login']
    @repos = body
  end

  def create
    resp = Faraday.post("https://api.github.com/user/repos") do |req|
      req.params['name'] = params[:name]
      req.headers['Authorization'] = params[:authenticity_token]
      # req.headers['Authorization'] = session[:token]
    end
    
    redirect_to root_path
  end
end
