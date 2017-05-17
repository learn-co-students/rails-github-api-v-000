class RepositoriesController < ApplicationController
    before_action :authenticate_user
    def index
        resp = Faraday.get('https://api.github.com/user/repos') do |req|
            req.headers['Accept'] = 'application/json'
            req.headers['Authorization'] ="token #{session[:token]}"
        end
        if resp["error"]

        else
            @repos = JSON.parse(resp.body)
        end
    end

    def create 
        resp = Faraday.post('https://api.github.com/user/repos') do |req|
            req.headers['Accept'] = 'application/json'
            req.headers['Authorization'] ="token #{session[:token]}"
            req.body['name'] = params[:name].to_json
        end
#        byebug
        redirect_to root_path
    end
end
