Entitat certificadora Veritat Abosulta

 ```bash
 [root@i17 ldapserver]# openssl req -new -x509 -nodes -out cacert.pem -days 365 -keyout cakey.pem
Generating a 2048 bit RSA private key
........................................................................................+++
................................+++
writing new private key to 'cakey.pem'
-----
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [XX]:ca
State or Province Name (full name) []:barcelona
Locality Name (eg, city) [Default City]:barcelona
Organization Name (eg, company) [Default Company Ltd]:veritat absoluta
Organizational Unit Name (eg, section) []:certs
Common Name (eg, your name or your server's hostname) []:veritat
Email Address []:admin@veritat.org
 ```

generar request de ldapserver
 ```bash
[root@i17 ldapserver]# openssl req -new -newkey rsa:2048 -keyout serverkey.pem -nodes -out servercsr.pem
Generating a 2048 bit RSA private key
...+++
................................................................................................+++
writing new private key to 'serverkey.pem'
-----
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [XX]:ca
State or Province Name (full name) []:barcelona
Locality Name (eg, city) [Default City]:barcelona
Organization Name (eg, company) [Default Company Ltd]:ldapserver
Organizational Unit Name (eg, section) []:certs
Common Name (eg, your name or your server's hostname) []:ldapserver
Email Address []:admin@ldapserver.org

Please enter the following 'extra' attributes
to be sent with your certificate request
A challenge password []:jupiter
An optional company name []:edt
 ```

signar el request de ldapserver
 ```bash
[root@i17 ldapserver]# openssl x509 -CA cacert.pem -CAkey cakey.pem -req -in servercsr.pem -CAcreateserial -out servercert.pem
Signature ok
subject=/C=ca/ST=barcelona/L=barcelona/O=ldapserver/OU=certs/CN=ldapserver/emailAddress=admin@ldapserver.org
Getting CA Private Key
 ```




