# Laporan Resmi Modul 2 Jaringan Komputer

Lapres Modul 2 Jaringan Komputer - **IT-03**

## Authors

| Nama                                                | NRP        |
| --------------------------------------------------- | ---------- |
| [Sighra Attariq Sumere Jati](https://www.github.com/sgraa) | 5027221068 |
| [Wilson Matthew Thendry](https://www.github.com/waifuwetdream) | 5027221024 |

## Hasil Pengerjaan

### Soal 1

### Soal 2

### Soal 3

### Soal 4

### Soal 5

### Soal 6

### Soal 7

### Soal 8

### Soal 9

### Soal 10

### Soal 11

### Soal 12

Diminta untuk deploy website dengan menggunnakan `apache` pada **Serverny**
```sh
echo '<VirtualHost  *:8080>

	ServerAdmin webmaster@localhost
	DocumentRoot /var/www/web-8080

	ErrorLog ${APACHE_LOG_DIR}/error.log
	CustomLog ${APACHE_LOG_DIR}/access.log combined

</VirtualHost>' > /etc/apache2/sites-available/default-8080.conf

echo 'Listen 8080' >> /etc/apache2/ports.conf
```
Dibuat config file untuk deploy server menggunakan port 8080 dengan folder `/var/www/web-8080` sebagai root.
```sh
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
```
Lalu masukkan resource website yang sudah disediakan ke dalam folder root website.

![Output](/images/Soal12_Output.png)

Gunakan `lynx 10.65.2.3:8080` (ip address **Serverny** = 10.65.2.3) untuk membuka website yang dihosting pada **Serverny**.

### Soal 13

Diminta untuk membuat load balancer pada web sebelumnya, dengan **Serverny**, **Stalber**, dan **Lipovka** sebagai worker dan **Mylta** sebagai load balancer.

- Set up worker

    Untuk worker tambahan yaitu **Stalber** dan **Lipovka** bisa dilakukan konfigurasi yang sama dengan **Serverny** pada [Soal 12](#soal-12).

- Set up load balacer

    ```sh
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
    </VirtualHost>" > /etc/apache2/sites-available/default-8080.conf

    echo 'Listen 8080' >> /etc/apache2/ports.conf
    ```
    Dibuat konfigurasi balancer yang mengarah ke 3 worker yang sudah dibuat pada port 8080, sehingga ketika mengakses web melalui load balancer akan diarahkan ke 3 worker tersebut secara bergantian.

Gunakan `lynx 10.65.2.5:8080` (ip address **Mylta** = 10.65.2.5) untuk mengakses website melalui load balancer. ![Lynx](/images/Soal13_Lynx.png)

![Output 1](/images/Soal13_Output1.png)
![Output 2](/images/Soal13_Output2.png)
![Output 3](/images/Soal13_Output3.png)

Dari output tersebut dapat dilihat bahwa load balancer membagi load pada setiap worker secara bergantian setiap ada request masuk.

### Soal 14

Diminta untuk mengubah semua worker dan load balancer yang sudah dibuat dari menggunakan **apache** menjadi **nginx**.

- Set up worker
    
    ```sh
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
    ```
    Dibuat konfigurasi untuk semua worker (bisa menggunakan script yang sama) pada port 6969 dengan tetap menggunakan folder root website yang sama seperti sebelumnya yaitu `/var/www/web-8080`.

- Set up load balancer

    ```sh
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
    ```
    Dibuat konfigurasi balancer yang sama seperti sebelumnya dan mengarah ke 3 worker yang sudah dibuat pada port 69.

Gunakan `lynx 10.65.2.5:69` (ip address **Mylta** = 10.65.2.5) untuk mengakses ketiga worker melalui load balancer. ![Lynx](/images/Soal14_Lynx.png)

![Output 1](/images/Soal14_Output1.png)
![Output 2](/images/Soal14_Output2.png)
![Output 3](/images/Soal14_Output3.png)

Dari output tersebut dapat dilihat bahwa load balancer membagi load pada setiap worker secara bergantian setiap ada request masuk.