service php7.0-fpm start

echo 'server {
        listen 6969;

        root /var/www/web-8080;
        index index.php index.html index.htm index.nginx-debian.html;

        server_name _;

        location / {
                try_files $uri $uri/ /index.php?$query_string;
        }

        location ~ \.php$ {
                include snippets/fastcgi-php.conf;
                fastcgi_pass unix:/run/php/php7.0-fpm.sock;
        }

        location ~ /\.ht {
                deny all;
        }
}' > /etc/nginx/sites-available/web-8080

ln -s /etc/nginx/sites-available/web-8080 /etc/nginx/sites-enabled/web-8080

rm /etc/nginx/sites-enabled/default

service nginx restart