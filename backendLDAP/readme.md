# Server Kerberos amb Backend LDAP

## Overview

In this model, we will perform a Server Kerberos with a LDAP backend. This means that the kerberos database is sotred in a remot LDAP server.
For this we will use a kerberos server _krb.edt.org_ and a _ldapserver_ using TLS.


## Instalation
### Hostnames and ips

- Kerberos Server: krb.edt.org 172.11.0.2
- LDAP Server: ldapserver 172.11.0.3


#### Create Docker Network

_This is important for an easily comunication between servers and clients._

 ```bash
 # docker network create --subnet 172.11.0.0/16 kerberos
 ```

If you want to salt the two next steps just use my image:
 ```bash
 # docker run --name krb.edt.org --hostname pkserver --net kerberos --ip 172.11.0.2  -d isx434324/backendldap:kserver
 ```

#### Create image
_As we are in the directories_
[krb.edt.org](https://github.com/isx434324/kerberosproject/tree/master/backendLDAP/krb.edt.org)
[ldapserver](https://github.com/isx434324/kerberosproject/tree/master/backendLDAP/ldapserver)

 ```bash
 # docker build -t krb.edt.org .
 # docker build -t ldapserver .
 ```
 
#### Run container for kerberos and ldap servers
 ```bash
 # docker run --name krb.edt.org --hostname kserver --net kerberos --ip 172.11.0.2  --privileged=True -d krb.edt.org
 # docker run --name ldapserver --hostname ldapserver --net kerberos --ip 172.11.0.3  --privileged=True -d ldapserver
 ```

As the container is not interactive, you can acces:

    docker exec -it krb.edt.org /bin/bash
    docker exec -it ldapserver /bin/bash
 
 
