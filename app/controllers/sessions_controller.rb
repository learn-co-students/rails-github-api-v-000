class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    github = GithubService.new
    session[:access_token] = github.authenticate!(ENV["GITHUB_CLIENT_ID"],
                                                  ENV["GITHUB_CLIENT_SECRET"],
                                                  params[:code])
    redirect_to root_path
  end
end
