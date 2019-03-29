class RepositoriesController < ApplicationController

  before_action :authenticate_user

  def index
    resp = Faraday.get "https://api.github.com/user/repos", {}, {"Authorization" => "token #{session[:token]}", "Accept" => "application/json"}
    @repos = JSON.parse(resp.body)

    @username = session[:username]

    # client = Octokit::Client.new(:access_token => session[:token])
    # @repos = client.repos
    #
    # last_response = client.last_response
    # number_of_pages = last_response.rels[:last].href.match(/page=(\d+).*$/)[1]
    #
    # @prev_page_href = client.last_response.rels[:prev] ? client.last_response.rels[:prev].href : nil
    # @next_page_href = client.last_response.rels[:next] ? client.last_response.rels[:next].href : nil

  end


  def create
    resp = Faraday.post "https://api.github.com/user/repos", {}, {"Authorization" => "token #{session[:token]}", "name" => params[:name], "Accept" => "application/json"}

    redirect_to '/'
  end

end
