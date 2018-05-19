# Server Kerberos amb Backend LDAP

## Overview

In this model, we will perform a Server Kerberos with a LDAP backend. This means that the kerberos database is stored in a remot LDAP server.
For this we will use a kerberos server _krb.edt.org_ and a _ldapserver_ using TLS.


## Instalation
### Hostnames and ips

- Kerberos Server: krbldap.edt.org 172.11.0.11

#### Create image
_As we are in the directories_
[krbldap.edt.org](https://github.com/isx434324/kerberosproject/tree/master/backendLDAP/krbldap.edt.org)

 ```bash
 # docker build -t krbldap.edt.org .
 ```
 
#### Run container for kerberos and ldap servers
 ```bash
 # docker run --name krbldap.edt.org --hostname kbldap.edt.org --net kerberos --ip 172.11.0.11  --privileged=True -d krbldap.edt.org
 
 ```

As the container is not interactive, you can acces:

    docker exec -it krb.edt.org /bin/bash
 
 
