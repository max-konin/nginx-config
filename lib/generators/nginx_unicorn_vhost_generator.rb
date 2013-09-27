class NginxUnicornVhostGenerator < Rails::Generators::Base
  def create_instance server_name, domain
    create_file "config/nginx_unicorn_instance",
                "
                upstream #{server_name}_server {
                server unix:/var/www/#{server_name}/shared/unicorn.sock fail_timeout=0;
                }

                server {
                  listen 80 default deferred;

                  client_max_body_size 1G;
                  server_name #{domain};
                  keepalive_timeout 5;
                  root /var/www/#{server_name}/current/public;
                      try_files $uri/index.html $uri.html $uri @myapp;

                  location @myapp {
                      proxy_pass http://#{server_name}_server;
                  proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                  proxy_set_header Host $http_host;
                  proxy_redirect off;
                }

                error_page 500 502 503 504 /500.html;
                location = /500.html {
                  root /var/www/#{server_name}/current/public;
                }
                }
                "
  end
end