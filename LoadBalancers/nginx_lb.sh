#address
serverny="10.65.2.3"
stalber="10.65.2.2"
lipovka="10.65.2.4"

echo "upstream backend {
  server ${serverny}:6969;
  server ${stalber}:6969;
  server ${lipovka}:6969;
}

server {
  listen 69;
  server_name mylta.it03.com www.mylta.it03.com;

  location / {
    proxy_pass http://backend;
  }
}
" > /etc/nginx/sites-available/web-8080

ln -s /etc/nginx/sites-available/web-8080 /etc/nginx/sites-enabled

service nginx  restart