# Model 4 - IMAP Kerberized

## Features

In this model, we will perform an IMAP server using kerberos authentication.

## Instalation
### Hostnames and ips

- Kerberos Server: krb.edt.org 172.11.0.2
- IMAP Server: krb.edt.org 172.11.0.2
RECORDA FER LA PROVA DESDE EL CLIENT


#### Create image
_As we are in the directori [kftpserver](https://github.com/isx434324/kerberosproject/backendClassic/kftpserver)_

 ```bash
 # docker build -t kimapserver .
 ```
 
#### Run container for kerberos server
 ```bash
 # docker run --name kimapserver --hostname imappserver --net kerberos --ip 172.11.0.6  -d kimapserver
 ```

As the container is not interactive, you can acces:
 
 ```bash
    docker exec -it krb.edt.org /bin/bash
 ```


 ```bash

 ```


 ```bash

 ```

 ```bash

 ```
 
  ```bash


 ```

 ```bash


 ```


 ```bash

 ```
 
 
  ```bash



 ```









