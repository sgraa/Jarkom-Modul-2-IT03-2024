mkdir /etc/bind/jarkom
cp /etc/bind/db.local /etc/bind/jarkom/airdrop.it03.com

echo 'zone "airdrop.it03.com" {
        type master;
        file "/etc/bind/jarkom/airdrop.it03.com";
        also-notify { 10.65.1.5; }; // IP Georgopol
        allow-transfer { 10.65.1.5; }; // IP Georgopol
};
zone "redzone.it03.com" {
        type master;
        file "/etc/bind/jarkom/redzone.it03.com";
        notify yes;
        also-notify { 10.65.1.5; }; // IP Georgopol
        allow-transfer { 10.65.1.5; }; // IP Georgopol
};
zone "loot.it03.com" {
        type master;
        file "/etc/bind/jarkom/loot.it03.com";
        notify yes;
        also-notify { 10.65.1.5; }; // IP Georgopol
        allow-transfer { 10.65.1.5; }; // IP Georgopol
};
zone "2.65.10.in-addr.arpa" {
        type master;
        file "/etc/bind/jarkom/2.65.10.in-addr.arpa";
};
' > /etc/bind/named.conf.local

echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     airdrop.it03.com. root.airdrop.it03.com. (
                        2024050301      ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      airdrop.it03.com.
@       IN      A       10.65.2.2     ; IP Stalber
www     IN      CNAME   airdrop.it03.com.
medkit  IN      A       10.65.2.4     ;' > /etc/bind/jarkom/airdrop.it03.com

cp /etc/bind/db.local /etc/bind/jarkom/redzone.it03.com

echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     redzone.it03.com. root.redzone.it03.com. (
                        2024050301      ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      redzone.it03.com.
@       IN      A       10.65.2.3     ; IP Severny
www     IN      CNAME   redzone.it03.com.
ns1     IN      A       10.65.1.5     ; IP Georgopol
siren   IN      NS      ns1' > /etc/bind/jarkom/redzone.it03.com

echo "options {
    directory \"/var/cache/bind\";
    allow-query { any; };
    auth-nxdomain no;
    listen-on-v6 { any; };
};" > /etc/bind/named.conf.options

cp /etc/bind/db.local /etc/bind/jarkom/loot.it03.com

echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     loot.it03.com. root.loot.it03.com. (
                        2024050301      ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      loot.it03.com.
@       IN      A       10.65.2.5     ; IP Mylta
www     IN      CNAME   loot.it03.com.' > /etc/bind/jarkom/loot.it03.com

echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     redzone.it03.com. root.redzone.it03.com. (
                        2024050301      ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
2.65.10.in-addr.arpa.   IN      NS      redzone.it03.com.
3                       IN      PTR     redzone.it03.com.' > /etc/bind/jarkom/2.65.10.in-addr.arpa

service bind9 restart