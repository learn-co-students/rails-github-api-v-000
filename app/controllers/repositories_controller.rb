class RepositoriesController < ApplicationController

  # def index #version that lists all pages fully
  #   @repos = []
  #   page_num = 1
  #   resp = Faraday.get "https://api.github.com/user/repos?per_page=100&page=#{page_num}", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
  #   while !JSON.parse(resp.body).empty?
  #     resp = Faraday.get "https://api.github.com/user/repos?per_page=100&page=#{page_num}", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
  #     @repos.push(*(JSON.parse(resp.body)))
  #     page_num +=1
  #   end
  # end

  def index
    resp = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    @repos = JSON.parse(resp.body)
  end

#   def index
#   response = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
#   @repos_array = JSON.parse(response.body)
# end

  # def create
  #   conn = Faraday.new("https://api.github.com")
  #
  # 	resp = conn.post do |req|
  # 		req.url '/user/repos'
  # 		req.headers['Content-Type'] = 'application/json'
  # 		req.headers['Authorization'] = "token #{session[:token]}"
  # 		req.body = {'name': params[:name]}.to_json
  # 	end
  #   # binding.pry
  #   redirect_to root_path
  # end

  # def create
  #   conn = Faraday.new(url: 'https://api.github.com/user/repos')
  #   dummy = conn.post do |req|
  #     req.headers = { Accept: 'application/json',
  #                     Authorization: "token #{session[:token]}" }
  #     req.body = { name: params[:name] }.to_json
  #   end
  #   binding.pry
  #   redirect_to root_path
  # end

  def create
    response = Faraday.post "https://api.github.com/user/repos",{ name: params[:name] }.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    binding.pry
    redirect_to '/'
  end

  # def create
  #   response = Faraday.post "https://api.github.com/user/repos", {name: params[:name]}.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
  #   binding.pry
  #   redirect_to '/'
  # end

  # def create
  #   result = RestClient.post('https://api.github.com/user/repos', {name: params[:name], :authorization => "Token token=#{session[:token]}"})
  #   binding.pry
  # end
  # def create
  #   resp = Faraday.post('https://api.github.com/user/repos') do |req|
  #     req.headers['Authorization'] = "token #{session[:token]}"
  #     req.body = {name: params[:name]}.to_json
  #   end
  #   binding.pry
  # end
end
