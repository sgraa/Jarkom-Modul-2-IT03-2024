echo 'zone "airdrop.it03.com" {
    type slave;
    masters { 10.65.1.2; }; //IP Pochinki
    file "/var/lib/bind/airdrop.it03.com";
};

zone "redzone.it03.com" {
    type slave;
    masters { 10.65.2.3; };
    file "/var/lib/bind/redzone.it03.com";
};

zone "loot.it03.com" {
    type slave;
    masters { 10.65.1.2; };
    file "/var/lib/bind/loot.it03.com";
};
zone "siren.redzone.it03.com" {
        type master;
        file "/etc/bind/siren/siren.redzone.it03.com";
};'  > /etc/bind/named.conf.local

mkdir /etc/bind/siren

cp /etc/bind/db.local /etc/bind/siren/siren.redzone.it03.com

echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     siren.redzone.it03.com. root.siren.redzone.it03.com. (
                        2024050401      ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      siren.redzone.it03.com.
@       IN      A       10.65.2.3       ; IP Severny
www     IN      CNAME   siren.redzone.it03.com.
log     IN      A       10.65.2.3       ;' > /etc/bind/siren/siren.redzone.it03.com

echo "options {
    directory \"/var/cache/bind\";
    allow-query { any; };
    auth-nxdomain no;
    listen-on-v6 { any; };
};" > /etc/bind/named.conf.options

service bind9 restart




