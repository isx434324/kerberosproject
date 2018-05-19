
# Model 1 - Basic treatment of the kerberos database

## Overview

In this model, we will perform a Server Kerberos with a classic backend.
I put exemples of the principals orders for the basic management of a kerberos db2 database fro the beginning.
For this we will use a kerberos server _krb.edt.org_.

## Features

Manipulation and treatment of the kerberos database

- Kadmin/kadmin.local
- Date Format
- Principals
- Policies
- Global operations on the kerberos databse


## Instalation
### Hostnames and our ips

- Kerberos Server: krb.edt.org 172.11.0.2


 ```bash
 
 vi /etc/hosts
mkdir /etc/krb5kdc/
kdb5_ldap_util -D cn=admin,dc=edt,dc=org -w jupiter create -subtrees dc=edt,dc=org -r EDT.ORG -s -P masterkey
kdb5_ldap_util -D cn=admin,dc=edt,dc=org stashsrvpw -f /etc/krb5kdc/admin.stash cn=admin,dc=edt,dc=org

/usr/sbin/krb5kdc
/usr/sbin/kadmind 

kadmin.local
add user
posar passwd a kadmin
quit

kadmin -p kadmin/admin
 ```
