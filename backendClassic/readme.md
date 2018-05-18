# Models Backend Classic

## Overview

In these models, we will perform a Server Kerberos with a classic backend, a client unix that will use PAM for the kerberos autentication instead of the password and three different services that will work as kerberos client.


##Containers

Kerberos Server [krb.edt.org](https://github.com/isx434324/kerberosproject/tree/master/backendClassic/krb.edt.org)

Client Unix/PAM [kclient](https://github.com/isx434324/kerberosproject/tree/master/backendClassic/kclient)

Ssh Kerberitzat [ksshserver](https://github.com/isx434324/kerberosproject/tree/master/backendClassic/ksshserver)

FTP Kerberitzat [kftpserver](https://github.com/isx434324/kerberosproject/tree/master/backendClassic/kftpserver)

Imap Kerberitzat [kimapserver](https://github.com/isx434324/kerberosproject/tree/master/backendClassic/kimapserver)

### Hostnames and ips

- Network: kerberos 172.11.0.0/16
- Kerberos Server: krb.edt.org 172.11.0.2
- Client Unix/PAM: kclient 172.11.0.3
- SSH Kerberitzat: ksshserver 172.11.0.4
- FTP Kerberitzat: kftpserver 172.11.0.5
- IMAP Kerberitzat: kimapserver 172.11.0.6
- LDAP Server: cldapserver 172.11.0.7

### Servidor Kerberos
Manipulation and treatment of the kerberos database

- Kadmin/kadmin.local
- Date Format
- Principals
- Policies
- Global operations on the kerberos databse

### Model1
Client Unix/PAM

Process of the kerberos authentication of a user Unix without password.

su user
require kerberos password

### Model2
Ssh Kerberitzat
How the service ssh use kerberos for the autentication of a client unix that use ssh.
Add ssh to the kerberos keytab

Add user to kerberos database
The user obtain the ticket.
The user try to do a SSH session and doesn't require password because already has the kerberos credentials.


### Model3
FTP Kerberized

How a server ftp use kerberos for the clients authentication.

Configure PAM for using the module pam_krb5.so
Add a user (without passwrod unix) in ftp server, the same client must exist on kerberos database.

The ftp client try to acces to the service ftp and use the  kerberos passwrod to authenticate itself.

### Model4
Imap Kerberitzat

How a server imap use kerberos for clients authentication.

Configure PAM for using the module pam_krb5.so
Add a user (without passwrod unix) in imap server, the same client must exist on kerberos database.

The ftp client try to acces to the service ftp using telnet and use the  kerberos passwrod to authenticate itself.





