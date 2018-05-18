# Model 3 - FTP Kerberized

## Overview

In this model, we will perform a Server Kerberos with a classic backend.
I put exemples of the principals orders for the basic management of a kerberos db2 database fro the beginning.
For this we will use a kerberos server _krb.edt.org_.

## Features

Manipulation and treatment of the kerberos database

- Kadmin/kadmin.local
- Date Format
- Principals
- Policies
- Global operations on the kerberos databse


## Instalation
### Hostnames and our ips

- Kerberos Server: krb.edt.org 172.11.0.2


#### Create Docker Network

_This is important for an easily comunication between servers and clients._

 ```bash
 # docker network create --subnet 172.11.0.0/16 kerberos
 ```

If you want to salt the two next steps just use my image:
 ```bash
 # docker run --name krb.edt.org --hostname pkserver --net kerberos --ip 172.11.0.5  -d isx434324/backendClassic:kftpserver
 ```

#### Create image
_As we are in the directori [kftpserver](https://github.com/isx434324/kerberosproject/backendClassic/kftpserver)_

 ```bash
 # docker build -t kftpserver .
 ```
 
#### Run container for kerberos server
 ```bash
 # docker run --name kftpserver --hostname kftpserver --net kerberos --ip 172.11.0.5  -d kftpserver
 ```

As the container is not interactive, you can acces:
 
 ```bash
    docker exec -it krb.edt.org /bin/bash
 ```


 ```bash
[root@kftp docker]# vim /etc/pam.d/vsftpd
#%PAM-1.0
session    optional     pam_keyinit.so    force revoke
auth       required	pam_listfile.so item=user sense=deny file=/etc/vsftpd/ftpusers onerr=succeed
auth       required	pam_shells.so
#auth       include	password-auth
auth       sufficient   pam_krb5.so

#account    include	password-auth
account     sufficient  pam_krb5.so

session    required     pam_loginuid.so
#session    include	password-auth
session    sufficient   pam_krb5.so
 ```


 ```bash
[root@kftp docker]# useradd tania
 ```

 ```bash
[root@kftp docker]# echo "primer fitxer per tania" > /var/ftp/prova01.txt
 ```
 
  ```bash
[root@kftp docker]# cat startup.sh 
#!/bin/bash
/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf

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









