class RepositoriesController < ApplicationController
  skip_before_action :authenticate_user
  def index
    resp = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    @repositories = Kaminari.paginate_array(JSON.parse(resp.body)).page(params[:page])
  end

  def create
    resp = Faraday.post "https://api.github.com/user/repos", {name: params[:name]}.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    redirect_to root_path
  end
end
