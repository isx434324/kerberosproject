# Model 1 - Basic treatment of the kerberos database

## Overview

In these models, we will perform a Server Kerberos with a classic backend, a client unix that will use PAM for the kerberos autentication instead of the password and three different services that will work as kerberos client.


##Containers

Kerberos Server [krb.edt.org](https://github.com/isx434324/kerberosproject/backendClassic/krb.edt.org)
Client Unix/PAM [kclient](https://github.com/isx434324/kerberosproject/backendClassic/kclient)
Ssh Kerberitzat [ksshserver](https://github.com/isx434324/kerberosproject/backendClassic/ksshserver)
Servei1 Kerberitzat [kservice1server](https://github.com/isx434324/kerberosproject/backendClassic/kservice1server)
Servei2 Kerberitzat [kservice2server](https://github.com/isx434324/kerberosproject/backendClassic/kservice2server)

### Hostnames and ips

- Network: kerberos 172.11.0.0/16
- Kerberos Server: krb.edt.org 172.11.0.2
- Client Unix/PAM: kclient 172.11.0.3
- Ssh Kerberitzat: ksshserver 172.11.0.4
- Service1 Kerberitzat: kservice1server 172.11.0.5
- Service2 Kerberitzat: kservice2server 172.11.0.6

### Model1
Manipulation and treatment of the kerberos database

- Kadmin/kadmin.local
- Date Format
- Principals
- Policies
- Global operations on the kerberos databse

### Model2
Client Unix/PAM

Process of the kerberos authentication of a user Unix without password.

su user
require kerberos password

### Model3
Ssh Kerberitzat
How the service ssh use kerberos for the autentication of a client unix that use ssh.
Add ssh to the kerberos keytab

Add user to kerberos database
The user obtain the ticket
[client@localhost]$ ssh client@sshserver don't require password


### Model4
Servei1 Kerberitzat

How the service use kerberos for the autentication of a client unix that use the service
Add servei to the kerberos keytab

Add user to kerberos database
The user obtain the ticket
when user the service don't require password

### Model5
Servei2 Kerberitzat

How the service use kerberos for the autentication of a client unix that use the service
Add servei to the kerberos keytab

Add user to kerberos database
The user obtain the ticket
when user the service don't require password



