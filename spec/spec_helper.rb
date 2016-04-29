ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

require 'capybara/dsl'
require 'capybara/rails'
require 'capybara/rspec'
require 'webmock/rspec'
require 'rack_session_access/capybara'

RSpec.configure do |config|
  config.include Capybara::DSL

  config.before(:each) do
    stub_request(:get, "https://api.github.com/user/repos").
      with(:headers => {'Authorization'=>'token 1'}).
      to_return(:status => 200, :body => [{"name" => "Repo 1", "html_url" => "http://link1.com"}, {"name" => "Repo 2", "html_url" => "http://link2.com"}, {"name" => "Repo 3", "html_url" => "http://link3.com"}].to_json, :headers => {})

    stub_request(:post, "https://github.com/login/oauth/access_token").
      with(:body => {"client_id"=> ENV["GITHUB_CLIENT"], "client_secret"=> ENV["GITHUB_SECRET"], "code"=>"20"},
      :headers => {'Accept'=>'application/json'}).
      to_return(:status => 200, :body => {"access_token"=>"1"}.to_json, :headers => {})

    stub_request(:get, "https://api.github.com/user").
      with(:headers => {'Authorization'=>'token 1'}).
      to_return(:status => 200, :body => {"login"=>"your_username"}.to_json, :headers => {})

    stub_request(:post, "https://api.github.com/user/repos").
      with(:body => {"{\"name\":\"a-new-repo\"}"=>true},
      :headers => {'Authorization'=>'token 1'}).
      to_return(:status => 201, :body => "", :headers => {})

    stub_request(:post, "https://github.com/login/oauth/access_token?client_id=0d15c6e5fb2d920ee4f6&client_secret=3b49c26f59d366bf9a42895c4f412f0aa371710a&code=20&redirect_uri=http://localhost:3000/auth").
         with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Length'=>'0', 'User-Agent'=>'Faraday v0.9.2'}).
         to_return(:status => 200, :body => "", :headers => {})

    stub_request(:get, "https://api.github.com/user/repos?access_token=1").
         with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.2'}).
         to_return(:status => 200, :body => "", :headers => {})

    stub_request(:get, "https://api.github.com/user/repos?access_token=1").
         with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.2'}).
         to_return(:status => 200, :body => "", :headers => {})

  end
end

WebMock.disable_net_connect!(allow_localhost: true)