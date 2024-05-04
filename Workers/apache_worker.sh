service php7.0-fpm start

cd /etc/apache2/sites-available
echo '<VirtualHost  *:8080>

	ServerAdmin webmaster@localhost
	DocumentRoot /var/www/web-8080

	ErrorLog ${APACHE_LOG_DIR}/error.log
	CustomLog ${APACHE_LOG_DIR}/access.log combined

</VirtualHost>' > default-8080.conf

cd ..
echo 'Listen 8080' >> ports.conf

a2ensite default-8080.conf
service apache2 restart

cd /var/www
mkdir web-8080 && cd web-8080
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
?>" > index.php

