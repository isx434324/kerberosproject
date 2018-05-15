# Models Backend Classic

## Overview

In these models, we will perform a Server Kerberos with a classic backend, a client unix that will use PAM for the kerberos autentication instead of the password and three different services that will work as kerberos client.


##Containers

Kerberos Server [krb.edt.org](https://github.com/isx434324/kerberosproject/tree/master/backendClassic/krb.edt.org)

Client Unix/PAM [kclient](https://github.com/isx434324/kerberosproject/tree/master/backendClassic/kclient)

Ssh Kerberitzat [ksshserver](https://github.com/isx434324/kerberosproject/tree/master/backendClassic/ksshserver)

FTP Kerberitzat [kftpserver](https://github.com/isx434324/kerberosproject/tree/master/backendClassic/kftpserver)

Servei2 Kerberitzat [kservice2server](https://github.com/isx434324/kerberosproject/tree/master/backendClassic/kservice2server)

### Hostnames and ips

- Network: kerberos 172.11.0.0/16
- Kerberos Server: krb.edt.org 172.11.0.2
- Client Unix/PAM: kclient 172.11.0.3
- SSH Kerberitzat: ksshserver 172.11.0.4
- FTP Kerberitzat: kftpserver 172.11.0.5
- Service2 Kerberitzat: kservice2server 172.11.0.6

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
The user obtain the ticket
[client@localhost]$ ssh client@sshserver don't require password


### Model3
FTP Kerberized

How a server ftp use kerberos for the autentication of the ftp clients.
Add ftp to the kerberos keytab

Configure PAM for using the module pam_krb5.so
Add a user (without passwrod unix) in ftp server, the same client must exist on kerberos database.

The ftp client try to acces to the service ftp and use the  kerberos passwrod to authenticate itself.

### Model4
Servei2 Kerberitzat

How the service use kerberos for the autentication of a client unix that use the service
Add service to the kerberos keytab

Add user to kerberos database
The user obtain the ticket
when the user use the service don't require password



