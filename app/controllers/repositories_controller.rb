class RepositoriesController < ApplicationController
  
  def index
    @errors = session[:errors] unless session[:errors].nil?

    begin
      user_response = Faraday.get 'https://api.github.com/user' do |req|
        req.headers['Authorization'] = "token #{session[:token]}"
        req.headers['Accept'] = 'application/json'
      end
    user_body = JSON.parse(user_response.body)
    if user_response.success?
      @username = user_body["login"]
    else
      @error = user_body["meta"]["errorDetail"]
    end

    rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again."
    end

    begin
      repos_response = Faraday.get 'https://api.github.com/user/repos' do |req|
        # client_id = ENV['GITHUB_CLIENT_ID']
        # client_secret = ENV['GITHUB_CLIENT_SECRET']
        # req.body = { 'client_id': client_id, 'client_secret': client_secret}
        req.headers['Authorization'] = "token #{session[:token]}"
        req.headers['Accept'] = 'application/json'
      end
    repos_body = JSON.parse(repos_response.body)
    if repos_response.success?
      @repos = repos_body
    else
      @error = repos_body["meta"]["errorDetail"]
    end

    rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again."
    end
    render 'index'
  end

end
