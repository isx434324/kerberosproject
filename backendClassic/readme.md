# Models Backend Classic

## Overview

In these models, we will perform a Server Kerberos with a classic backend, a client unix that will use PAM for the kerberos autentication instead of the password and three different services that will work as kerberos client.


### Hostnames and ips

- Network: kerberos 172.11.0.0/16
- Kerberos Server: [krb.edt.org](https://github.com/isx434324/kerberosproject/tree/master/backendClassic/krb.edt.org) 172.11.0.2
- Client Unix/PAM: [kclient](https://github.com/isx434324/kerberosproject/tree/master/backendClassic/kclient) 172.11.0.3
- SSH Kerberitzat: [ksshserver](https://github.com/isx434324/kerberosproject/tree/master/backendClassic/ksshserver) 172.11.0.4
- FTP Kerberitzat: [kftpserver](https://github.com/isx434324/kerberosproject/tree/master/backendClassic/kftpserver) 172.11.0.5
- IMAP Kerberitzat: [kimapserver](https://github.com/isx434324/kerberosproject/tree/master/backendClassic/kimapserver) 172.11.0.6
- LDAP Server: [ldap.edt.org](https://github.com/isx434324/kerberosproject/tree/master/backendClassic/ldap.edt.org) 172.11.0.7


### Create Docker Network

_This is important for an easily comunication between servers and clients._

 ```bash
 # docker network create --subnet 172.11.0.0/16 kerberos
 ```


### Server Kerberos
Manipulation and treatment of the kerberos database

- Kadmin/kadmin.local
- Date Format
- Principals
- Policies
- Global operations on the kerberos databse

### Model1
Client Unix/PAM

Process of the kerberos authentication of a user Unix having the account information in a server LDAP and the password in the Kerberos Server.

 ```bash
$ su - user
Password: kerberos_password
Creating directory '/tmp/home/user'.
-sh-4.3$ pwd
/tmp/home/pau
 ```


### Model2
Ssh Kerberitzat

The use of the service SSH using kerberos credentials instead of a local/unix password fot the user authentication.


 ```bash
[root@kclient docker]# kinit tania
Password for tania@EDT.ORG: ktania
 ```
 ```bash
 [root@kclient docker]# ssh tania@ksshserver
The authenticity of host 'ksshserver (172.11.0.4)' can't be established.
ECDSA key fingerprint is SHA256:BSe2q+Ce8nKbsMCd+QHhpY25TdUDgnGaiNeF4AItyPA.
ECDSA key fingerprint is MD5:12:90:86:11:ee:20:1f:d1:bf:0b:12:aa:cf:9a:33:31.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added 'ksshserver,172.11.0.4' (ECDSA) to the list of known hosts.
[tania@ksshserver ~]$ logout
Connection to ksshserver closed.
 ```

### Model3
FTP Kerberized

Server FTP use kerberos for clients authentication using module pam_krb5.so.

Having the principal in the kerberos database it's possible to use the service FTP even without a unix password.

 ```bash
[root@kftp docker]# useradd tania
 
[root@kclient docker]# ftp 172.11.0.5
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

### Model4
Imap Kerberitzat

Servei IMAP use kerberos for clients authentication using module pam_krb5.so even without a unix password.
Note that the principal must exist in kerberos database.

 ```bash
[root@kimapserver docker]# telnet localhost 143
Trying ::1...
Connected to localhost.
Escape character is '^]'.
* OK [CAPABILITY IMAP4REV1 I18NLEVEL=1 LITERAL+ SASL-IR LOGIN-REFERRALS STARTTLS] localhost IMAP4rev1 2007f.404 at Wed, 16 May 2018 09:47:02 +0000 (UTC)

a login pere kpere
a OK [CAPABILITY IMAP4REV1 I18NLEVEL=1 LITERAL+ IDLE UIDPLUS NAMESPACE CHILDREN MAILBOX-REFERRALS BINARY UNSELECT ESEARCH WITHIN SCAN SORT THREAD=REFERENCES THREAD=ORDEREDSUBJECT MULTIAPPEND]

User pere authenticated

a logout
* BYE kimapserver IMAP4 rev1 server terminating connection
a OK LOGOUT completed
Connection closed by foreign host.
 ```

