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
useradd tania

 ```

We connect 
Having the ssh and kerberos running we are going to create a new principal for the service and add the service to the keytab.

 ```bash
 addprinc -randkey
 ktadd -k
 ```
We can prove it using the user tania/admin that has privileges in the kerberos server:

 ```bash

kdamin.local -p tania/admin
listprincs

 ```
 
Right we have tania@EDT.ORG and the principal for the sshserver.
Note that the unix user tania must also exist in the kerberos database to get the credentials.


As a client we are going to get the credentials to use the ssh service
 ```bash
kinit tania
ktania
 ```
 
If the authentication was succesfull we'll have an output like this.
  ```bash
klist


 ```


Right we have the credentials, now we can acces to ksshserver without using a password because we are trusted for ssh by kerberos server.
 
 ```bash
ssh tania@ksshserver

 ```
