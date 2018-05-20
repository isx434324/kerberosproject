# Model 2 - Complete authentication of a client UNIX using PAM.

## Overview

Using a Kerberos Server with a classic backend we are going to use kerberos authentication having the users information in a ldapserver and the password in the kerberos server.
It must exist an account  on the kerberos server database with the name of the user to get the ticket.

Assume the [Kerberos](https://github.com/isx434324/kerberosproject/tree/master/backendClassic/krb.edt.org) and [LDAP](https://github.com/isx434324/kerberosproject/tree/master/backendClassic/ldap.edt.org) Servers are running.

## Instalation
### Hostname and ip

- Client Unix/PAM: kclient       172.11.0.3

#### Create image

 ```bash
 # docker build -t kclient .
 ```

 
#### Run container
 ```bash
 # docker run --name kclient --hostname kclient --net kerberos --ip 172.11.0.3 -it kclient
 
 ```

In this model it's only necessary to have the client interactive.

 ```bash
    docker exec -it kclient /bin/bash
 ```

Prove the client can use the LDAP users (pau, pere, anna..).

 ```bash
[root@kclient docker]# getent passwd 
root:x:0:0:root:/root:/bin/bash
bin:x:1:1:bin:/bin:/sbin/nologin
daemon:x:2:2:daemon:/sbin:/sbin/nologin
adm:x:3:4:adm:/var/adm:/sbin/nologin
lp:x:4:7:lp:/var/spool/lpd:/sbin/nologin
sync:x:5:0:sync:/sbin:/bin/sync
shutdown:x:6:0:shutdown:/sbin:/sbin/shutdown
halt:x:7:0:halt:/sbin:/sbin/halt
mail:x:8:12:mail:/var/spool/mail:/sbin/nologin
operator:x:11:0:operator:/root:/sbin/nologin
games:x:12:100:games:/usr/games:/sbin/nologin
ftp:x:14:50:FTP User:/var/ftp:/sbin/nologin
nobody:x:99:99:Nobody:/:/sbin/nologin
systemd-timesync:x:999:998:systemd Time Synchronization:/:/sbin/nologin
systemd-network:x:998:997:systemd Network Management:/:/sbin/nologin
systemd-resolve:x:997:996:systemd Resolver:/:/sbin/nologin
systemd-bus-proxy:x:996:995:systemd Bus Proxy:/:/sbin/nologin
dbus:x:81:81:System message bus:/:/sbin/nologin
tania:x:1000:1000::/home/tania:/bin/bash
nscd:x:28:28:NSCD Daemon:/:/sbin/nologin
nslcd:x:65:55:LDAP Client User:/:/sbin/nologin
pau:*:5000:100:Pau Pou:/tmp/home/pau:
pere:*:5001:100:Pere Pou:/tmp/home/pere:
anna:*:5002:600:Anna Pou:/tmp/home/anna:
marta:*:5003:600:Marta Mas:/tmp/home/marta:
jordi:*:5004:100:Jordi Mas:/tmp/home/jordi:
admin:*:10:10:Administrador Sistema:/tmp/home/admin:
 ``` 

Note that the user must have an account in the kerberos server database. (To create it see the section [Principals](https://github.com/isx434324/kerberosproject/tree/master/backendClassic/krb.edt.org) in the kerberos management documentation.).

Prove user exists in kerberos database:

 ```bash
[root@kclient docker]# kadmin -p tania/admin -q "listprincs"
Authenticating as principal tania/admin with password.
Password for tania/admin@EDT.ORG: 
K/M@EDT.ORG
ftp/kimapserver@EDT.ORG
host/cldapserver@EDT.ORG
kadmin/7537780ad6ad@EDT.ORG
kadmin/admin@EDT.ORG
kadmin/changepw@EDT.ORG
kiprop/7537780ad6ad@EDT.ORG
krbtgt/EDT.ORG@EDT.ORG
pere@EDT.ORG
tania/admin@EDT.ORG
tania@EDT.ORG
 ``` 

As we have pau in the kerberos and ldap database we can login using the kerberos password kpere. 
(First login as tania to not have the permissions directly from root.)

 ```bash
[root@kclient docker]# su tania

[tania@kclient docker]$ su - pere
Password: pere
su: Authentication failure

[tania@kclient docker]$ su - pere
Password: kpere
Creating directory '/tmp/home/pere'.
-sh-4.3$ pwd
/tmp/home/pere

 ``` 


If the user was properly authenticated will have a ticket from the kerberos server.

 ```bash
-sh-4.3$ klist 
Ticket cache: DIR::/run/user/5000/krb5cc_hHGf15/tktzaK5kX
Default principal: pere@EDT.ORG

Valid starting     Expires            Service principal
05/18/18 09:19:59  05/19/18 09:19:59  krbtgt/EDT.ORG@EDT.ORG
 ``` 
 

