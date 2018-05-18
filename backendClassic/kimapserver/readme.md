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

[root@kclient docker]# ftp 172.11.0.11
Connected to 172.11.0.11 (172.11.0.11).
Trying ::1...
Connected to localhost (::1).
220 Welcome to FTP service, password kerberos.
Name (localhost:root): tania
331 Please specify the password.
Password: ktania
230 Login successful.
Remote system type is UNIX.
Using binary mode to transfer files.
ftp> ls
229 Entering Extended Passive Mode (|||27840|)
150 Here comes the directory listing.
226 Directory send OK.
ftp> get /var/ftp/prova01.txt filetania.txt
local: filetania.txt remote: /var/ftp/prova01.txt
227 Entering Passive Mode (172,11,0,11,24,0).
150 Opening BINARY mode data connection for /var/ftp/prova01.txt (14 bytes).
226 Transfer complete.
14 bytes received in 0.000214 secs (65.42 Kbytes/sec)
ftp> quit
221 Goodbye.
 ```


 ```bash
[root@kclient docker]# ls
Dockerfile  filetania.txt  krb5.conf  system-auth
 ```
 
 
  ```bash
[root@kclient docker]# cat filetania.txt 
primer fitxer per tania


 ```









