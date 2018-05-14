class RepositoriesController < ApplicationController
  before_action :authenticate_user
  #{session[:username]}
  #def index

    def index
  response = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}

  @repos = JSON.parse(response.body)
end
#     response= Faraday.get("https://api.github.com/user/nicoleeidi/repos") do |req|
#       #req.params['oauth_token']= session[:token] #is this the right way ?
# req.headers['accept']='application/json'
# req.headers['authorization']= "token #{session[:token]}"
#     end
# #session[:username] is nil... and maybe we dont need that because it's not actually needed in the URL...
# binding.pry
#     @repos= JSON.parse(response.body)
  #end
  def create
     response = Faraday.post "https://api.github.com/user/repos", {name: params[:name]}.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
     redirect_to '/'
 end
  # def create #makes post to github API to create repo
  #   response= Faraday.post("https://api.github.com/user/repos") do |req|
  #     req.params['name']= params[:name]
  #     req.headers['accept']='application/json'
  #     req.headers['authorization']= "token #{session[:token]}"
  #   end
  #   redirect_to '/'
  # end

end
