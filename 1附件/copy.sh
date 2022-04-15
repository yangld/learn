cp ca.pem server-*.pem /var/lib/mysql -v
chown -v mysql.mysql /var/lib/mysql/{ca,server*}.pem

