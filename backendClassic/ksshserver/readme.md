# Model 2 - SSH Kerberized

## Overview

In this model, we will perform a SSH Server that user Kerberos Authentication.

## Features

In this model we supossed to have the kerberos server running. (See [krb.edt.org](https://github.com/isx434324/kerberosproject/backendClassic/krb.edt.org)) and one interactive client to do the ssh session (See [kclient](https://github.com/isx434324/kerberosproject/backendClassic/kclient))
We are going to see how a client ssh (kclient) can connect to a remote sshserver using his kerberos credentials instead of the local unix password.

## Instalation
### Hostnames and ips

- Kerberos Server: krb.edt.org 172.11.0.2
- Kclient:         kclient     172.11.0.3
- SSH Server:      ksshserver  172.11.0.4

#### Create image
_As we are in the directori [ksshserver](https://github.com/isx434324/kerberosproject/backendClassic/ksshserver)_

 ```bash
 # docker build -t ksshserver .
 ```

#### Run container SSH server
 ```bash
 # docker run --name ksshserver --hostname ksshserver --net kerberos --ip 172.11.0.4  -d ksshserver
 ```

As the containers are not interactive, you can acces:

    docker exec -it ksshserver /bin/bash
Add the user tania without a unix password 
 ```bash
[root@ksshserver docker]# useradd tania

 ```

Having the ssh and kerberos running and using the user tania/admin that has privileges in the kerberos server we are going to create a new principal for the service and add the service to the keytab.

 ```bash
 [root@ksshserver docker]# kadmin -p tania/admin -w ktania -q "addprinc -rand>
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
We can see:

 ```bash

[root@ksshserver docker]# kadmin -p tania/admin -w ktania -q "listprincs"
Authenticating as principal tania/admin with password.
K/M@EDT.ORG
host/ksshserver@EDT.ORG
imap/kimapserver@EDT.ORG
kadmin/980b470dd63a@EDT.ORG
kadmin/admin@EDT.ORG
kadmin/changepw@EDT.ORG
kiprop/980b470dd63a@EDT.ORG
krbtgt/EDT.ORG@EDT.ORG
pere@EDT.ORG
tania/admin@EDT.ORG
tania@EDT.ORG

 ```
 
Right, we have the principal host/ksshserver@EDT.ORG.
Note that the unix user tania must also exist in the kerberos database to get the credentials.


As a client, we are going to get the credentials to use the ssh service
 ```bash
[root@kclient docker]# kinit tania
Password for tania@EDT.ORG: ktania
 ```
 
If the authentication was succesfull we'll have an output like this.
  ```bash
[root@kclient docker]# klist
Ticket cache: FILE:/tmp/krb5cc_0
Default principal: tania@EDT.ORG

Valid starting     Expires            Service principal
05/18/18 08:11:14  05/19/18 08:11:14  krbtgt/EDT.ORG@EDT.ORG

 ```


Right we have the credentials, now we can acces to ksshserver without using a password because we are trusted for ssh by kerberos server.

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