# Working with APIs

In this lab, we're going to dive into GitHub's OAuth functionality and build our
own OAuth Rails application. Refer to [this tutorial][tutorial] and the
[Github OAuth documentation][oauthdoc] as you work through this lab.

- `http://localhost:3000` is visited. _Before_ a user is routed to something like
  `repositories#index` and a view, _if the user is not logged in_, the application
  controller redirects the user to GitHub to provide their identity.
- On successfully confirmation of identity, GitHub redirects the user based on the
  'Authorization callback URL' provided when the OAuth application was created. In
  our case, back to `http://localhost:3000/auth`. GitHub passes along a `code`
  param, as well.
- `http://localhost:3000/auth` routes to a sessions controller. In the sessions
  controller, we use the Client ID and Client Secret, as well as the `code` param
  by sending them in a POST back to GitHub. If this information is correct, GitHub
  will respond with an `access_token`.
- By including the `access_token` on GitHub API requests from our code, GitHub knows
  we are making authenticated requests and lets us do more things. We can now access
  account and repository information and even create repositories on behalf of logged-in
  users!

## Objectives

- Work through configuring OAuth with GitHub on a Rails app

## Instructions

1.  First, Set up a new [OAuth application on GitHub][newoauth]. For the
    'Authorization callback URL' we can use `http://localhost:3000/auth`.
    Once set up, you will be provided a Client ID and Client Secret.

2.  Create a `.env` file where you can store your unique ID and Secret as
    `GITHUB_CLIENT` and `GITHUB_SECRET`. The `dotenv` gem will read this
    file, finds out our secrets and securely passes them to our Rails app.

3.  Our Rails application will need to mimic GitHub's OAuth web application flow.
    The following routes are provided:

```ruby
get '/auth' => 'sessions#create'
post '/repositories/create' => 'repositories#create'
root 'repositories#index'
```

A user visiting `http://localhost:3000/` will be routed to the root path.
Before `repositories#index` can be invoked, we want to check if the user is
authenticated. Write `authenticate_user` and `logged_in?` methods in
`application_controller.rb` that will be called before every action. In
`authenticate_user`, if the user isn't logged in (i.g. no session token), we
will redirect to GitHub. The base URL here will be
`https://github.com/login/oauth/authorize` and will use the Client ID as a
parameter.

3.  If set up properly, running `rails s` and heading to `http://localhost:3000`
    should cause a GitHub login to appear. Don't worry about authorizing just yet
    (it is possible to get stuck in a loop here, redirecting to GitHub over and
    over, since we haven't finished our application). Since we set the
    'Authorization callback URL' to `http://localhost:3000/auth`, once a user signs
    in to GitHub and authorizes the use of OAuth, they will be redirected back to
    our app and routed to `sessions#create`.

4.  In `sessions_controller.rb`, write a `create` method. This method should
    receive GitHub's `code` parameter and should use it in conjunction with your
    Client ID and Client Secret to send a _POST_ request to GitHub. The base URL
    this time will be `https://github.com/login/oauth/access_token`.

    **Note:** It is entirely possible to get this workflow working using query
    params appended to the end of the URL (i.g.
    `https://github.com/login/oauth/access_token?client_id=...`). However, it is
    generally best for security to not send IDs, secrets and tokens this way.
    Instead, we typically send this content in request headers or in the body.

    For GitHub, we will include our Client ID, Secret and code as
    part of the body of the request:

    ```ruby
    response = Faraday.post "https://github.com/login/oauth/access_token" do |req|
      req.body = { 'client_id': client_id, 'client_secret': client_secret, 'code': code }
      req.headers['Accept'] = 'application/json'
    end
    ```

    Notice here, we are also including an 'Accept' header, as well. In this
    case, we are telling GitHub's server that we will accept JSON as a response.

    If the credentials are correct, GitHub will send a response that includes
    headers and a body. Within the body is an access token unique to this specific
    request.

    As is the case whenever data is sent from an API or web server, the response
    body is sent in the form of a string. Before we can get data from this
    string, we will need to parse it into a hash:

    ```ruby
    body = JSON.parse(response.body)
    ```

    The above code parses the response body into a Ruby hash and stores this
    hash as the `body` variable. Whatever key value pairs were sent by GitHub
    will now be available, including `body['access_token']`.

    We will need this token whenever we send API requests, so the best
    place to store this would be with in `session`. Setting something like
    `session[:token]` to be equal to the parsed `'access_token'` value will
    allow us to access the token in other controllers.

    After parsing and storing the token as a value in `session`, redirect to our
    root path at the end of the `create` method.

5.  When we are routed to `repositories#index`, our root path,
    `authenticate_user` is called again. This time, however, since there is now a
    `session[:token]`, the user will not redirected and our
    `repositories/index.html.erb` file will be displayed.

6.  Call the GitHub API from within `repositories#index` to retrieve and display
    the current user's 'login' in `repositories/index.html.erb`.

7.  Call the API a second time using `https://api.github.com/user/repos` to
    retrieve and display a list of repositories on `repositories/index.html.erb`.
    Displaying only the first page of results is fine; feel free to tackle
    pagination as a bonus.

**BONUS:** Implement a `create` action in your `RepositoriesController` so that the form on
`index.html.erb` successfully creates a new repository for the current user. The
form input should be the name of the new repository. Redirect back to `'/'`. If
successful, you should be able to see your newly created repository on your
GitHub account.

**Hint:** You may not be able to trigger `pry` when testing your application with `rails s`. However, if you include `binding.pry` in your controllers, you _can_
trigger it when running tests.

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/rails-github-api' title='Working with APIs'>Working with APIs</a> on Learn.co and start learning to code for free.</p>

[tutorial]: https://github.com/learn-co-curriculum/web-auth-readme
[newoauth]: https://github.com/settings/applications/new
[oauthdoc]: https://developer.github.com/apps/building-oauth-apps/authorizing-oauth-apps/
