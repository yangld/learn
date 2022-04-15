openssl genrsa 2048 > ca-key.pem 
openssl req -new -x509 -nodes -days 3600 -key ca-key.pem -out ca.pem

openssl req -newkey rsa:2048 -days 3600 -nodes -keyout server-key.pem -out server-req.pem
openssl rsa -in server-key.pem -out server-key.pem
openssl x509 -req -in server-req.pem -days 3600  -CA ca.pem -CAkey ca-key.pem -set_serial 01 -out server-cert.pem

openssl req -newkey rsa:2048 -days 3600 -nodes -keyout client-key.pem -out client-req.pem
openssl rsa -in client-key.pem -out client-key.pem
openssl x509 -req -in client-req.pem -days 3600 -CA ca.pem -CAkey ca-key.pem -set_serial 01 -out client-cert.pem

keytool -importcert -alias Cacert -file ca.pem  -keystore truststoremysql -storepass pekall1234


openssl pkcs12 -export -in client-cert.pem -inkey client-key.pem -name "mysqlclient" -passout pass:pekall1234 -out client-keystore.p12
keytool -importkeystore -srckeystore client-keystore.p12 -srcstoretype pkcs12 -srcstorepass pekall1234 -destkeystore keystoremysql -deststoretype JKS -deststorepass pekall1234
