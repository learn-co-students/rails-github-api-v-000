module ApplicationHelper
	def current_user
		resp = Faraday.get("https://api.github.com/user") do |req|
  			req.headers["Authorization"] = "token #{session[:token]}"
  			req.headers['Accept'] = 'application/json'
  		end
  		body = JSON.parse(resp.body)
  	    return body["login"]
	end
end
