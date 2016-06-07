class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    @resp = Faraday.post "https://github.com/login/oauth/access_token" do |req|
      req.params['client_id'] = ENV['GITHUB_CLIENT_ID']
    end
  end

end