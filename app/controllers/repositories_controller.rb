class RepositoriesController < ApplicationController
  #before_action :authenticate_user

  def index
  end

  def create
  end

  private

  def authenticate_user
    client_id = '35595bdf7017f9ad88ec'
    redirect_uri = 'http://165.227.90.214:45912/auth'
    github_url = "https://github.com/login/oauth/authorize?client_id=#{client_id}&redirect_uri=#{redirect_uri}"
    redirect_to github_url unless logged_in?
  end

  def logged_in?
    !!session[:token]
  end

end
