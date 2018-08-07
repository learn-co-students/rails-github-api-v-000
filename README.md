class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user

  private

    def authenticate_user
      redirect_to "https://github.com/login/oauth/authorize?client_id=#{ENV['GITHUB_CLIENT']}&scope=repo" if !logged_in?
    end

    def logged_in?
      !!session[:token]
    end
end# Working with APIs

## Instructions

1. Refer to [this tutorial](https://github.com/learn-co-curriculum/web-auth-readme) and the [Github OAuth documentation](https://developer.github.com/v3/oauth/) to implement authentication with the GitHub API. Display the current user's username on the `index` page in a heading.

2. On the repositories `index` page, display a list of the current user's repositories. Displaying only the first page of results is fine; feel free to tackle pagination as a bonus.

3. Implement the `create` action in your `RepositoriesController` so that the form on `index.html.erb` successfully creates a new repository for the current user. The form input should be the name of the new repository. Redirect back to `'/'`.
  * **Note:** The Github API requires the body of the POST be valid JSON.

4. Your solution will "make it work", but we want to move the API calls out of the controllers. Once the tests pass, [learn how to refactor your code in the next lab](https://github.com/learn-co-curriculum/rails-refactoring-apis). This is important – don't skip it!
<p data-visibility='hidden'>View <a href='https://learn.co/lessons/rails-github-api' title='Working with APIs'>Working with APIs</a> on Learn.co and start learning to code for free.</p>
