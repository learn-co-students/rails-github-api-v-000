ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

require 'capybara/dsl'
require 'capybara/rails'
require 'capybara/rspec'
require 'webmock/rspec'
require 'rack_session_access/capybara'
WebMock.disable_net_connect!(allow_localhost: true)


RSpec.configure do |config|
  config.include Capybara::DSL

  config.before(:each) do
    stub_request(:get, "https://api.github.com/user/repos?access_token=1").
      with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Faraday v0.9.1'}).
      to_return(:status => 200, :body => [{"name" => "Repo 1", "html_url" => "http://link1.com"}, {"name" => "Repo 2", "html_url" => "http://link2.com"}, {"name" => "Repo 3", "html_url" => "http://link3.com"}].to_json, :headers => {})

    stub_request(:post, "https://github.com/login/oauth/access_token?client_id=1eaee94864080fc6d2f3&client_secret=b1605efba3927f14812ea7dd8cc419b4c9f8fed3&code=20").
      with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Length'=>'0', 'User-Agent'=>'Faraday v0.9.1'}).
      to_return(:status => 200, :body => {"access_token"=>"1"}.to_json, :headers => {})

    stub_request(:get, "https://api.github.com/user?access_token=1").
       with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Faraday v0.9.1'}).
      to_return(:status => 200, :body => {"login"=>"your_username"}.to_json, :headers => {})

    stub_request(:post, "https://api.github.com/user/repos?access_token=1").
      with(:body => "{ 'name': 'a-new-repo' }",
              :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Faraday v0.9.1'}).

      to_return(:status => 201, :body => "", :headers => {})
  end
end
