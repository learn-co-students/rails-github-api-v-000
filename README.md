# Working with APIs

## APIs and the Web

Until now, we've been working with APIs via some lovely Ruby gems. But what's really going on behind the scenes? According to [Wikipedia](https://en.wikipedia.org/wiki/Web_API):
> A server-side web API is a programmatic interface to a defined request-response message system, typically expressed in JSON or XML, which is exposed via the web—most commonly by means of an HTTP-based web server.

What does this mean? That by sending out a series of GET and POST requests, we can communicate with APIs to receive and send information.

## Authentication without the OAuth Gem

Take a look at the [OAuth section of the GitHub API Documentation](https://developer.github.com/v3/oauth/), specifically the first sub-section, called 'Web Application Flow'. This documentation lists three steps to make API calls: redirect users to request GitHub access, GitHub redirects back to your site, and use the access token to access the API.

#### Redirect users to request GitHub access

First off, you need to [register your application with GitHub](https://github.com/settings/applications/new). In this case, your redirect URL is `http://localhost:3000/auth`, which takes you to `sessions#create`. Your homepage URL is `http://localhost:3000/`. You also need to create a `.env` [file](https://github.com/bkeepers/dotenv) that holds your `GITHUB_CLIENT` and `GITHUB_SECRET`.

Ultimately, users will be considered "logged in" if they have an access token stored in their session. So, let's create a private method `#logged_in?` in your `ApplicationController` that will return false if `session[:token]` is nil and true otherwise:

```ruby
private
  def logged_in?
    !!session[:token]
  end
```

Now, write another private method `#authenticate_user` that will redirect the user to `https://github.com/login/oauth/authorize` _if_ the user is not already logged in. According to the GitHub API documentation, you'll need to send a few parameters along with your redirection: here, `client_id` should have a value of `ENV[GITHUB_CLIENT]`, and `scope` should have a value of `repo`. You can send these parameters via a [query string](https://en.wikipedia.org/wiki/Query_string).

Once you've implemented `#authenticate_user`, set the authentication as a `before_action` in your `ApplicationController`. In your `SessionsController`, skip the `before_action` with `skip_before_action :authenticate_user, only: :create`. Now, whenever users do not have an access token stored in their session, they will be redirected to the GitHub authorization URL.

#### GitHub redirects back to your site

When you registered your application, you set your redirect URL to `http://localhost:3000/auth`. This is where GitHub is sending users after the login process. In your `routes.rb` file, the line `get '/auth' => 'sessions#create'` signifies that the redirection process will land the user in the `create` action in `SessionsController`.

Back to our handy documentation! GitHub redirects users with a code that can be accessed through `params` and exchanged for an access token, given the proper POST request. We're going to use [Faraday](https://github.com/lostisland/faraday) to send GET and POST requests within your Rails application. You can build these requests by calling `Faraday.get` or `Faraday.post` with three arguments: the URL, a parameters hash, and a headers hash.

According to the docs, you need to send a POST request to `https://github.com/login/oauth/access_token` with the parameters `client_id`, `client_secret`, and `code`:

```ruby
response = Faraday.post "https://github.com/login/oauth/access_token", 
  {client_id: ENV["GITHUB_CLIENT"], client_secret: ENV["GITHUB_SECRET"], 
    code: params[:code]}, 
  {'Accept' => 'application/json'}
```

Use `JSON.parse` to parse the response body into a hash, and then store the access token in `session[:token]`.

#### Use the access token to access the API

Now that users have their API tokens, they can make calls to all of the API endpoints as long as those tokens are included in the headers as authorization. The GitHub API documentation says to include the following header: `Authorization: token OAUTH-TOKEN`.

Take a look at the [Users section](https://developer.github.com/v3/users/) for some examples of API calls. Let's get the user's login name and store it in the user's session upon login.

According to the documentation, the call to get the authenticated user is `GET /user`. We don't need to send any parameters, so our parameters hash will be empty. As far as headers, we need our Authorization header and our Accept header.

At the bottom of your `create` action in `SessionsController`, make a call to the GitHub API:

```ruby
user_response = Faraday.get "https://api.github.com/user", 
  {}, 
  {'Authorization' => "token #{session[:token]}", 
    'Accept' => 'application/json'}
```

Parse the response body using JSON, and save the username to `session[:username]`. Finally, redirect back to `'/'`.

## Instructions

1. Follow the tutorial above to implement authentication with the GitHub API. Display the current user's username on the `index` page in a heading.

2. On the repositories `index` page, display a list of the current user's repositories. Displaying only the first page of results is fine; feel free to tackle pagination as a bonus.

3. Implement the `create` action in your `RepositoriesController` so that the form on `index.html.erb` successfully creates a new repository for the current user. The form input should be the name of the new repository. Redirect back to `'/'`. (HINT: Your parameters hash should be passed in as JSON. How can you accomplish this? Can you think of a method that will convert a hash to JSON?)