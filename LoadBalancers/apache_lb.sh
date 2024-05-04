#package
a2enmod proxy
a2enmod proxy_http
a2enmod proxy_balancer
a2enmod lbmethod_byrequests
service php7.0-fpm start

cd /etc/apache2/sites-available/

#address
serverny="10.65.2.3"
stalber="10.65.2.2"
lipovka="10.65.2.4"

#config file
echo "<VirtualHost *:8080>
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/web-8080

    ProxyRequests Off
    <Proxy balancer://mycluster>
        BalancerMember http://${serverny}:8080
        BalancerMember http://${stalber}:8080
        BalancerMember http://${lipovka}:8080
        ProxySet lbmethod=byrequests
    </Proxy>

    ProxyPass / balancer://mycluster/
    ProxyPassReverse / balancer://mycluster/
</VirtualHost>" > default-8080.conf

cd ..
echo 'Listen 8080' >> ports.conf

a2ensite default-8080.conf
service apache2 restart