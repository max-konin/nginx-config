class NginxUnicornVhostGenerator < Rails::Generators::NamedBase
  argument :domain, :type => :string, :required => true, :desc => "site's domain"
  def create_instance
    create_file "config/#{name}.vhost",
                "upstream #{name}_server {
server unix:/var/www/#{name}/shared/unicorn.sock fail_timeout=0;
}

server {
  listen 80 default deferred;

  client_max_body_size 1G;
  server_name #{domain};
  keepalive_timeout 5;
  root /var/www/#{name}/current/public;
      try_files $uri/index.html $uri.html $uri @myapp;

  location @myapp {
      proxy_pass http://#{name}_server;
  proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
  proxy_set_header Host $http_host;
  proxy_redirect off;
}

error_page 500 502 503 504 /500.html;
location = /500.html {
  root /var/www/#{name}/current/public;
}
}
"
  end
end
