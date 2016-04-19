class RepositoriesController < ApplicationController
  def index
    binding.pry
    
    resp = Faraday.get("https://api.github.com/user/repos") do |req|
      req.params['access_token'] = "653cfc6938393aaa580d7662cef1376f12aa8fca"
    end
  end

  def create
  end
end
