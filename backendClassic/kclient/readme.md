# Model 2 - Complete authentication of a client UNIX with PAM.

## Overview

Using a Kerberos Server with a classic backend the unix user can autenticate itself using the kerberos password instead of a password unix.

## Features
It have to exist an account  on the kerberos server database with the name of the user to get the ticket.

## Instalation
### Hostnames and our ips

- Kerberos Server: krb.edt.org 172.11.0.2
- Client Unix/PAM: kclient     172.11.0.3

#### Create Docker Network

_This is important for an easily comunication between servers and clients._

 ```bash
 # docker network create --subnet 172.11.0.0/16 kerberos
 ```

If you want to salt the two next steps just use my images:
 ```bash
 # docker run --name krb.edt.org --hostname kserver --net kerberos --ip 172.11.0.2  -d isx434324/backendclasic:krb.edt.org
 ```
 ```bash
 # docker run --name kclient --hostname kclient --net kerberos --ip 172.11.0.3  -d isx434324/backendclasic:kclient
 ```

#### Create images
Using the directory

[kclient](https://github.com/isx434324/kerberosproject/tree/master/backendClassic/kclient)

 ```bash
 # docker build -t kclient . 
 ```

 
#### Running interactive container 
 ```bash
 # docker run --name kclient --hostname kclient --net kerberos --ip 172.11.0.3 -it kclient
 ```

In this model it's only necessary to have the client interactive.
Note that the user must have an account in the kerberos server database. (See the section [Principals](https://github.com/isx434324/kerberosproject/tree/master/backendClassic/krb.edt.org) in the kerberos management documentation.)

In this case we are going to prove with tania. (Password Kerberos: ktania)
Add the clients unix with no unix password to prove the kerberos autentication.

 ```bash
 # useradd pere
 # useradd tania
 ```
 
Do the login with pere to not have the permissions directly from root and use the kerberos password.
 ```bash
 [root@kclient docker]# su - pere
 [pere@kclient docker]$ su - tania
 Password: ktania
 ``` 

If the user was properly authenticated must have a ticket from the kerberos server
  ```bash
[tania@kclient ~]$ klist
Ticket cache: DIR::/run/user/1001/krb5cc_7mG8cW/tktybR7Ma
Default principal: tania@EDT.ORG

Valid starting     Expires            Service principal
05/10/18 07:44:19  05/11/18 07:44:19  krbtgt/EDT.ORG@EDT.ORG
 ```
