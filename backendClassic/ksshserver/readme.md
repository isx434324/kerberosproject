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


 ```bash

 ```


 ```bash

 ```

 ```bash

 ```
 
  ```bash


 ```

 ```bash


 ```


 ```bash

 ```
 
 
  ```bash


 ```




