=> [32m#<Faraday::Response:0x007fd184af3888[0m
 @env[32m=[0m
  [32m#<struct Faraday::Env[0m
   method[32m=[0m[33m:get[0m,
   body[32m=[0m
    [31m[1;31m"[0m[31m{[1;35m\"[0m[31mmessage[1;35m\"[0m[31m:[1;35m\"[0m[31mBad credentials[1;35m\"[0m[31m,[1;35m\"[0m[31mdocumentation_url[1;35m\"[0m[31m:[1;35m\"[0m[31mhttps://developer.github.com/v3[1;35m\"[0m[31m}[1;31m"[0m[31m[0m,
   url[32m=[0m
    [32m#<URI::HTTPS https://api.github.com/user/repos?access_token=%3D72932bc39109d4bba6d722dfb2b50c320f11cbeb%26>[0m,
   request[32m=[0m
    [32m#<struct Faraday::RequestOptions[0m
     params_encoder[32m=[0m[1;36mnil[0m,
     proxy[32m=[0m[1;36mnil[0m,
     bind[32m=[0m[1;36mnil[0m,
     timeout[32m=[0m[1;36mnil[0m,
     open_timeout[32m=[0m[1;36mnil[0m,
     boundary[32m=[0m[1;36mnil[0m,
     oauth[32m=[0m[1;36mnil[0m[32m>[0m,
   request_headers[32m=[0m{[31m[1;31m"[0m[31mUser-Agent[1;31m"[0m[31m[0m=>[31m[1;31m"[0m[31mFaraday v0.9.1[1;31m"[0m[31m[0m},
   ssl[32m=[0m
    [32m#<struct Faraday::SSLOptions[0m
     verify[32m=[0m[1;36mtrue[0m,
     ca_file[32m=[0m[1;36mnil[0m,
     ca_path[32m=[0m[1;36mnil[0m,
     verify_mode[32m=[0m[1;36mnil[0m,
     cert_store[32m=[0m[1;36mnil[0m,
     client_cert[32m=[0m[1;36mnil[0m,
     client_key[32m=[0m[1;36mnil[0m,
     certificate[32m=[0m[1;36mnil[0m,
     private_key[32m=[0m[1;36mnil[0m,
     verify_depth[32m=[0m[1;36mnil[0m,
     version[32m=[0m[1;36mnil[0m[32m>[0m,
   parallel_manager[32m=[0m[1;36mnil[0m,
   params[32m=[0m[1;36mnil[0m,
   response[32m=[0m[1;36mnil[0m,
   response_headers[32m=[0m
    {[31m[1;31m"[0m[31mserver[1;31m"[0m[31m[0m=>[31m[1;31m"[0m[31mGitHub.com[1;31m"[0m[31m[0m,
     [31m[1;31m"[0m[31mdate[1;31m"[0m[31m[0m=>[31m[1;31m"[0m[31mTue, 01 May 2018 20:09:03 GMT[1;31m"[0m[31m[0m,
     [31m[1;31m"[0m[31mcontent-type[1;31m"[0m[31m[0m=>[31m[1;31m"[0m[31mapplication/json; charset=utf-8[1;31m"[0m[31m[0m,
     [31m[1;31m"[0m[31mcontent-length[1;31m"[0m[31m[0m=>[31m[1;31m"[0m[31m83[1;31m"[0m[31m[0m,
     [31m[1;31m"[0m[31mconnection[1;31m"[0m[31m[0m=>[31m[1;31m"[0m[31mclose[1;31m"[0m[31m[0m,
     [31m[1;31m"[0m[31mstatus[1;31m"[0m[31m[0m=>[31m[1;31m"[0m[31m401 Unauthorized[1;31m"[0m[31m[0m,
     [31m[1;31m"[0m[31mx-github-media-type[1;31m"[0m[31m[0m=>[31m[1;31m"[0m[31mgithub.v3; format=json[1;31m"[0m[31m[0m,
     [31m[1;31m"[0m[31mx-ratelimit-limit[1;31m"[0m[31m[0m=>[31m[1;31m"[0m[31m60[1;31m"[0m[31m[0m,
     [31m[1;31m"[0m[31mx-ratelimit-remaining[1;31m"[0m[31m[0m=>[31m[1;31m"[0m[31m49[1;31m"[0m[31m[0m,
     [31m[1;31m"[0m[31mx-ratelimit-reset[1;31m"[0m[31m[0m=>[31m[1;31m"[0m[31m1525208171[1;31m"[0m[31m[0m,
     [31m[1;31m"[0m[31maccess-control-expose-headers[1;31m"[0m[31m[0m=>
      [31m[1;31m"[0m[31mETag, Link, Retry-After, X-GitHub-OTP, X-RateLimit-Limit, X-RateLimit-Remaining, X-RateLimit-Reset, X-OAuth-Scopes, X-Accepted-OAuth-Scopes, X-Poll-Interval[1;31m"[0m[31m[0m,
     [31m[1;31m"[0m[31maccess-control-allow-origin[1;31m"[0m[31m[0m=>[31m[1;31m"[0m[31m*[1;31m"[0m[31m[0m,
     [31m[1;31m"[0m[31mstrict-transport-security[1;31m"[0m[31m[0m=>
      [31m[1;31m"[0m[31mmax-age=31536000; includeSubdomains; preload[1;31m"[0m[31m[0m,
     [31m[1;31m"[0m[31mx-frame-options[1;31m"[0m[31m[0m=>[31m[1;31m"[0m[31mdeny[1;31m"[0m[31m[0m,
     [31m[1;31m"[0m[31mx-content-type-options[1;31m"[0m[31m[0m=>[31m[1;31m"[0m[31mnosniff[1;31m"[0m[31m[0m,
     [31m[1;31m"[0m[31mx-xss-protection[1;31m"[0m[31m[0m=>[31m[1;31m"[0m[31m1; mode=block[1;31m"[0m[31m[0m,
     [31m[1;31m"[0m[31mreferrer-policy[1;31m"[0m[31m[0m=>
      [31m[1;31m"[0m[31morigin-when-cross-origin, strict-origin-when-cross-origin[1;31m"[0m[31m[0m,
     [31m[1;31m"[0m[31mcontent-security-policy[1;31m"[0m[31m[0m=>[31m[1;31m"[0m[31mdefault-src 'none'[1;31m"[0m[31m[0m,
     [31m[1;31m"[0m[31mx-runtime-rack[1;31m"[0m[31m[0m=>[31m[1;31m"[0m[31m0.015278[1;31m"[0m[31m[0m,
     [31m[1;31m"[0m[31mx-github-request-id[1;31m"[0m[31m[0m=>[31m[1;31m"[0m[31mA92E:4EF1:368A3:6A8EB:5AE8C95F[1;31m"[0m[31m[0m},
   status[32m=[0m[1;34m401[0m[32m>[0m,
 @on_complete_callbacks[32m=[0m[][32m>[0m
