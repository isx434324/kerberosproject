# Model 3 - FTP Kerberized

## Features

Having [Kerberos](https://github.com/isx434324/kerberosproject/tree/master/backendClassic/krb.edt.org) and [kclient](https://github.com/isx434324/kerberosproject/tree/master/backendClassic/kclient) interactive we will perform a FTP Server using kerberos authentication.


## Instalation
### Hostname and ip

- FTP Server: kftpserver 172.11.0.5

#### Create image

 ```bash
 # docker build -t kftpserver .
 ```
 
#### Run container
 ```bash
 # docker run --name kftpserver --hostname kftpserver --net kerberos --privileged --ip 172.11.0.5  -d kftpserver
 ```

As the container is not interactive, you can acces:

    docker exec -it kftpserver /bin/bash


Configure the use of PAM module in FTP daemon.
 
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

Add user without unix password.
 ```bash
[root@kftp docker]# useradd tania
 ```

Create shared file in FTP server.
 ```bash
[root@kftp docker]# echo "Hello Caramelloo!" > /var/ftp/prova01.txt
 ```
 
Start the service.
  ```bash
[root@kftp docker]# cat startup.sh 
#!/bin/bash
/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf

 ```

As client get the file in ftpserver using kerberos password (ktania).

 ```bash
[root@kclient docker]# ftp kftpserver
Connected to 172.11.0.5 (172.11.0.5).
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

The file is locally transfered.
 ```bash
[root@kclient docker]# ls
Dockerfile  cacert.pem	filetania.txt  krb5.conf  ldap.conf  nslcd.conf  nsswitch.conf	readme.md  startup.sh  system-auth

[root@kclient docker]# cat filetania.txt 
Hello Caramelloo!

 ```



