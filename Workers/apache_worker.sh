service php7.0-fpm start

echo '<VirtualHost  *:8080>

	ServerAdmin webmaster@localhost
	DocumentRoot /var/www/web-8080

	ErrorLog ${APACHE_LOG_DIR}/error.log
	CustomLog ${APACHE_LOG_DIR}/access.log combined

</VirtualHost>' > /etc/apache2/sites-available/default-8080.conf

echo 'Listen 8080' >> /etc/apache2/ports.conf

a2ensite default-8080.conf
service apache2 restart

mkdir /var/www/web-8080
echo "<?php
$hostname = gethostname();
$date = date('Y-m-d H:i:s');
$php_version = phpversion();
$username = get_current_user();



echo "Hello World!<br>";
echo "Saya adalah: $username<br>";
echo "Saat ini berada di: $hostname<br>";
echo "Versi PHP yang saya gunakan: $php_version<br>";
echo "Tanggal saat ini: $date<br>";
?>" > /var/www/web-8080/index.php

