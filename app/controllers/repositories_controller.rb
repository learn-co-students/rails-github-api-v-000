class RepositoriesController < ApplicationController
  require 'json'

  before_action :authenticate_user
  before_action :set_user

  def index

    resp = Faraday.get "https://api.github.com/user/repos" do |req|
      req.headers["Authorization"] = "token " + session[:token]
      # req.params["sort"] = "created"
    end

    @repos=JSON.parse(resp.body)
  end

  def create

    create_resp = Faraday.post "https://api.github.com/user/repos" do |req|
      req.headers["Authorization"] = "token " + session[:token]
      # req.headers['Accept']='application/json'
      req.body = { name: params[:name]}.to_json
    end

    # body=JSON.parse(create_resp.body)
    if create_resp.success?
      redirect_to '/'
    else
      @errors=body["errors"]
      render "repositories/index"
    end
  end

  private

    def set_user
      @user||=session[:current_user]
    end
end
