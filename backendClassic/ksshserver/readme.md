# Model 2 - SSH Kerberized

## Overview

In this model, we will perform a SSH Server that user Kerberos Authentication.

## Features

In this model we supossed to have the [kerberos](https://github.com/isx434324/kerberosproject/tree/master/backendClassic/krb.edt.org) and [SSH](https://github.com/isx434324/kerberosproject/tree/master/backendClassic/ksshserver) server running.
We are going to see how a client can connect to a remote SSH server using his kerberos credentials instead of local unix password.

## Instalation

#### Create image

 ```bash
 # docker build -t ksshserver .
 ```

#### Run container
 ```bash
 # docker run --name ksshserver --hostname ksshserver --net kerberos --privileged --ip 172.11.0.4  -d ksshserver
 ```

As the container is not interactive, you can acces:

    docker exec -it ksshserver /bin/bash

Add the user (Note it doesn't have a password already)
 ```bash
[root@ksshserver docker]# useradd tania
 ```

Using one with privileges in the kerberos server, create a new principal for the service SSH and add it to the keytab.

 ```bash
[root@ksshserver docker]# kadmin -p tania/admin -w ktania -q "addprinc -randkey host/ksshserver"
Authenticating as principal tania/admin with password.
WARNING: no policy specified for host/ksshserver@EDT.ORG; defaulting to no policy
Principal "host/ksshserver@EDT.ORG" created.
 
 
[root@ksshserver docker]# kadmin -p tania/admin -w ktania -q "ktadd -k /etc/krb5.keytab host/ksshserver"
 Authenticating as principal tania/admin with password.
Entry for principal host/ksshserver with kvno 2, encryption type aes256-cts-hmac-sha1-96 added to keytab WRFILE:/etc/krb5.keytab.
Entry for principal host/ksshserver with kvno 2, encryption type aes128-cts-hmac-sha1-96 added to keytab WRFILE:/etc/krb5.keytab.
Entry for principal host/ksshserver with kvno 2, encryption type des3-cbc-sha1 added to keytab WRFILE:/etc/krb5.keytab.
Entry for principal host/ksshserver with kvno 2, encryption type arcfour-hmac added to keytab WRFILE:/etc/krb5.keytab.
Entry for principal host/ksshserver with kvno 2, encryption type camellia256-cts-cmac added to keytab WRFILE:/etc/krb5.keytab.
Entry for principal host/ksshserver with kvno 2, encryption type camellia128-cts-cmac added to keytab WRFILE:/etc/krb5.keytab.
Entry for principal host/ksshserver with kvno 2, encryption type des-hmac-sha1 added to keytab WRFILE:/etc/krb5.keytab.
Entry for principal host/ksshserver with kvno 2, encryption type des-cbc-md5 added to keytab WRFILE:/etc/krb5.keytab.

 ```
See new principal host/ksshserver@EDT.ORG. for the SSH service:

 ```bash

[root@ksshserver docker]# kadmin -p tania/admin -w ktania -q "listprincs"
Authenticating as principal tania/admin with password.
K/M@EDT.ORG
host/ksshserver@EDT.ORG
kadmin/980b470dd63a@EDT.ORG
kadmin/admin@EDT.ORG
kadmin/changepw@EDT.ORG
kiprop/980b470dd63a@EDT.ORG
krbtgt/EDT.ORG@EDT.ORG
pere@EDT.ORG
tania/admin@EDT.ORG
tania@EDT.ORG

 ```

Note that the unix user tania must also exist in the kerberos database to get the credentials.

The client (server [kclient](https://github.com/isx434324/kerberosproject/tree/master/backendClassic/kclient)), get the credentials to start a ssh session.

 ```bash
[root@kclient docker]# kinit tania
Password for tania@EDT.ORG: ktania
 ```
 
If the authentication was succesfull, the client can list its credentials:
  ```bash
[root@kclient docker]# klist
Ticket cache: FILE:/tmp/krb5cc_0
Default principal: tania@EDT.ORG

Valid starting     Expires            Service principal
05/18/18 08:11:14  05/19/18 08:11:14  krbtgt/EDT.ORG@EDT.ORG

 ```


Acces to ksshserver without password because the credentials give previous authentication.

 ```bash
 [root@kclient docker]# ssh tania@ksshserver
The authenticity of host 'ksshserver (172.11.0.4)' can't be established.
ECDSA key fingerprint is SHA256:BSe2q+Ce8nKbsMCd+QHhpY25TdUDgnGaiNeF4AItyPA.
ECDSA key fingerprint is MD5:12:90:86:11:ee:20:1f:d1:bf:0b:12:aa:cf:9a:33:31.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added 'ksshserver,172.11.0.4' (ECDSA) to the list of known hosts.
Environment:
  USER=tania
  LOGNAME=tania
  HOME=/home/tania
  PATH=/usr/local/bin:/usr/bin
  MAIL=/var/mail/tania
  SHELL=/bin/bash
  SSH_CLIENT=172.11.0.3 60382 22
  SSH_CONNECTION=172.11.0.3 60382 172.11.0.4 22
  SSH_TTY=/dev/pts/0
  TERM=xterm
[tania@ksshserver ~]$ logout
Connection to ksshserver closed.
 ```
