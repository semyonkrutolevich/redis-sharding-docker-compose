openssl genrsa 4096 > ca.key
openssl req -new -x509 -nodes -sha256 -key ca.key -days 3650 -subj "/C=TR/CN=ornek" -out ca.crt

host_ip=$(cat /etc/hosts | grep ${HOSTNAME} | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b")
sed -i "s/HOST_NAME/${HOSTNAME}/g" ./request.cfg
sed -i "s/HOST_IP/${host_ip}/g" ./request.cfg

openssl req -config request.cfg -newkey rsa:2048 -nodes -sha256 -keyout redis.key -out redis.csr
openssl x509 -req -sha256 -days 365 -in redis.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out redis.crt -extfile request.cfg -extensions v3_req
openssl x509 -in redis.crt -text -noout

#CONVERT TO PEM
openssl x509 -in ca.crt -out ca.pem -outform PEM
