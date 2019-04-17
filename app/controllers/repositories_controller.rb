class RepositoriesController < ApplicationController

  before_action :authenticate_user


  def index


    #  response_user = Faraday.get("https://api.github.com/user") do |req|
    #      req.params["client_id"] = ENV['GITHUB_CLIENT_ID']
    #      req.params["client_secret"] = ENV['GITHUB_CLIENT_SECRET']
    #      req.params["access_token"] = session['token']
    #    end

    #    response_repos = Faraday.get("https://api.github.com/user/repos") do |req|
    #        req.params["client_id"] = ENV['GITHUB_CLIENT_ID']
    #        req.params["client_secret"] = ENV['GITHUB_CLIENT_SECRET']
    #        req.params["access_token"] = session['token']
    #      end


    #response = Faraday.get("https://api.github.com/user?client_id=#{ENV['GITHUB_CLIENT_ID']}&client_secret=#{ENV['GITHUB_CLIENT_SECRET']}&access_token=#{session[:token]}")


    #user_info = JSON.parse(response_user.body)
    #@login = user_info['login']

    #binding.pry
    #@repos = JSON.parse(response_repos.body)

  end

end
