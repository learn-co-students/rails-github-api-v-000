https://api.github.com/user?access_token=...
<% @repos.each do |repo| %>
  <li> <%= repo["name"] %> </li>
<% end %>
