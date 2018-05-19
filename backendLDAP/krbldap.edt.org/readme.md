
# Model 5 - Server Kerbreros using backend LDAP

## Overview

In this model, we will perform a Server Kerberos with an LDAP server, that means we are going to store the principals of the kerberos database in our LDAP Server (using a special schema for kerberos principals). In this example we perform both servers in the same container.

## Features


## Instalation
### Hostname and ip

- Kerberos Server: krbldap.edt.org 172.11.0.11

###
 ```bash
  vi /etc/hosts
 ```

 ```bash
 mkdir /etc/krb5kdc/
 ```

 ```bash
 kdb5_ldap_util -D cn=admin,dc=edt,dc=org -w jupiter create -subtrees dc=edt,dc=org -r EDT.ORG -s -P masterkey
 ```

 ```bash
 kdb5_ldap_util -D cn=admin,dc=edt,dc=org stashsrvpw -f /etc/krb5kdc/admin.stash cn=admin,dc=edt,dc=org
 ```

 ```bash
 /usr/sbin/krb5kdc
  /usr/sbin/kadmind 
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


kadmin.local
add user
posar passwd a kadmin
quit

kadmin -p kadmin/admin
 ```
