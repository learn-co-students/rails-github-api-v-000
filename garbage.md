https://api.github.com/user?access_token=...
<% @repos.each do |repo| %>
  <li> <%= repo["name"] %> </li>
<% end %>

def create
  requestbody = "{\"name\":\"" + params[:name]+"\"}"
  resp = Faraday.post("https://api.github.com/user/repos") do |req|
    req.headers['Authorization'] = 'token ' +session[:token]
    req.headers['Content-Type'] = 'application/json'
    req.body = requestbody
  end
  redirect_to root_path
end
