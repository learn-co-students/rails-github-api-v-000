class RepositoriesController < ApplicationController
  # The code below works but, won't pass the spec.
  # def index
  #   # GET /user/repos
  #   resp = Faraday.get("https://api.github.com/user/repos") do |req|
  #     req.params['oauth_token'] = session[:token]
  #     req.params['affiliation'] = 'owner'
  #   end
  # 
  #   @repositories = JSON.parse(resp.body)
  # end

  # # POST /user/repos
  # def create
  #   # params[:name]
  #   resp = Faraday.post("https://api.github.com/user/repos", {name: params[:name]}.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'})
  #   puts "#{resp.body}"
  #   redirect_to root_path
  # end
  
  #This code passes the spec.
  def index
    # GET /user
    # stub_request(:get, "https://api.github.com/user").
    #   with(:headers => {'Authorization'=>'token 1'}).
    #   to_return(:status => 200, :body => {"login"=>"your_username"}.to_json, :headers => {})
    
    user = Faraday.get("https://api.github.com/user", nil, {'Authorization'=> "token #{session[:token]}"})
    user_body = JSON.parse(user.body)
    @username = user_body["login"]
    
    # GET /user/repos
    # stub_request(:get, "https://api.github.com/user/repos").
    #   with(:headers => {'Authorization'=>'token 1'}).
    #   to_return(:status => 200, :body => [{"name" => "Repo 1", "html_url" => "http://link1.com"}, {"name" => "Repo 2", "html_url" => "http://link2.com"}, {"name" => "Repo 3", "html_url" => "http://link3.com"}].to_json, :headers => {})
    resp = Faraday.get("https://api.github.com/user/repos", nil, {'Authorization'=> "token #{session[:token]}"})
    @repositories = JSON.parse(resp.body)
  end
  
  
  def create
    # POST /user/repos
    # params[:name]
    # stub_request(:post, "https://api.github.com/user/repos").
    #   with(:body => {"{\"name\":\"a-new-repo\"}"=>true},
    #   :headers => {'Authorization'=>'token 1'}).
    #   to_return(:status => 201, :body => "", :headers => {})
    
    resp = Faraday.post("https://api.github.com/user/repos", {name: params[:name]}.to_json, {'Authorization' => "token #{session[:token]}"})
    redirect_to root_path
  end
end
