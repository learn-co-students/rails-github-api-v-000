class RepositoriesController < ApplicationController
  def index
      response = Faraday.get("https://api.github.com/user/repos") do |req|
          binding.pry
      end
  end

  def create
  end
end
