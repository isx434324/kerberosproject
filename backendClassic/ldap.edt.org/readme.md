#Ldapserver detached amb tls

## Overview

In this model, we will perform a Server Kerberos with a classic backend.

## Features

Manipulation and treat

## Instalation
### Hostnames and our ips

- Kerberos Server: krb.edt.org 172.11.0.2

#### Create image

 ```bash
 # docker build -t ldap.edt.org .
 ```
 
#### Run container for kerberos server
 ```bash
 # docker run --name ldap.edt.org --hostname ldap.edt.org --net kerberos --ip 172.11.0.7  -d ldap.edt.org
 ```

As the container is not interactive, you can acces:

 ```bash
    docker exec -it ldap.edt.org /bin/bash
 ```


Per consultar funcionament de tls
 ```bash
ldapsearch -x -LLL -H ldaps://ldapserver -s base
ldapsearch -x -LLL -ZZ -H ldap://ldapserver -s base
 ```

Per consultar base de dades existent
 ```bash
ldapsearch -x -LLL -b 'dc=edt,dc=org' dn
 ```

Per consultar el domini
 ```bash
kdb5_ldap_util -D cn=Manager,dc=edt,dc=org -w jupiter -H ldap://ldapserver -containerref cn=krbcontainer,dc=edt,dc=org view
kdb5_ldap_util -D cn=Manager,dc=edt,dc=org -w jupiter -H ldap://ldapserver -containerref cn=krbcontainer,dc=edt,dc=org list
 ```

