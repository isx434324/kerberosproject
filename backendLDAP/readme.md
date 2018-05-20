# Model 5 - Server Kerberos using backend LDAP

## Overview

In this model, we will perform a Server Kerberos with an LDAP server as backend.
This means we are going to store the kerberos database principals in a LDAP Server (using a special schema for kerberos principals).


## Instalation

### Hostname and ip
- Kerberos and LDAP server: krbldap.edt.org 172.11.0.11

#### Create image
_Being in the directory_
[krbldap.edt.org](https://github.com/isx434324/kerberosproject/tree/master/backendLDAP/krbldap.edt.org)

 ```bash
 # docker build -t krbldap.edt.org .
 ```
 
#### Run container
 ```bash
 # docker run --name krbldap.edt.org --hostname kbldap.edt.org --net kerberos --ip 172.11.0.11  --privileged -d krbldap.edt.org
 ```

As the container is not interactive:

    docker exec -it krbldap.edt.org /bin/bash
 

The LDAP server is already running so we are going start directly with the creation of the _Kerberos database_.

First step is configure the hosts in the server for establish comunication between Kerberos and LDAP adding the name of the LDAP server.

 ```bash
[root@krbldap docker]# vim /etc/hosts
[root@krbldap docker]# cat /etc/hosts
127.0.0.1	localhost
::1	localhost ip6-localhost ip6-loopback
fe00::0	ip6-localnet
ff00::0	ip6-mcastprefix
ff02::1	ip6-allnodes
ff02::2	ip6-allrouters
172.11.0.11	krbldap.edt.org krbldap ldapserver.edt.org
 ```

Create the kerberos database.
Note that is not recommended to put the passwords directly in the order.

 ```bash
[root@krbldap docker]# kdb5_ldap_util -D cn=admin,dc=edt,dc=org -w jupiter create -subtrees dc=edt,dc=org -r EDT.ORG -s -P masterkey
Initializing database for realm 'EDT.ORG'
 ```

If everything is ok you can consult the principals created doing an ldapsearch.

 ```bash
[root@krbldap docker]# ldapsearch -x -LLL dn
dn: dc=edt,dc=org

dn: ou=usuaris,dc=edt,dc=org

dn: ou=maquines,dc=edt,dc=org

dn: ou=clients,dc=edt,dc=org

dn: ou=productes,dc=edt,dc=org

dn: ou=hosts,dc=edt,dc=org

dn: ou=networks,dc=edt,dc=org

dn: ou=groups,dc=edt,dc=org

dn: cn=Pau Pou,ou=usuaris,dc=edt,dc=org

dn: cn=Pere Pou,ou=usuaris,dc=edt,dc=org

dn: cn=Anna Pou,ou=usuaris,dc=edt,dc=org

dn: cn=Marta Mas,ou=usuaris,dc=edt,dc=org

dn: cn=Jordi Mas,ou=usuaris,dc=edt,dc=org

dn: cn=krbldap.edt.org,dc=edt,dc=org

dn: cn=EDT.ORG,cn=krbldap.edt.org,dc=edt,dc=org

dn: krbPrincipalName=K/M@EDT.ORG,cn=EDT.ORG,cn=krbldap.edt.org,dc=edt,dc=org

dn: krbPrincipalName=krbtgt/EDT.ORG@EDT.ORG,cn=EDT.ORG,cn=krbldap.edt.org,dc=e
 dt,dc=org

dn: krbPrincipalName=kadmin/admin@EDT.ORG,cn=EDT.ORG,cn=krbldap.edt.org,dc=edt
 ,dc=org

dn: krbPrincipalName=kadmin/krbldap.edt.org@EDT.ORG,cn=EDT.ORG,cn=krbldap.edt.
 org,dc=edt,dc=org

dn: krbPrincipalName=kiprop/krbldap.edt.org@EDT.ORG,cn=EDT.ORG,cn=krbldap.edt.
 org,dc=edt,dc=org

dn: krbPrincipalName=kadmin/changepw@EDT.ORG,cn=EDT.ORG,cn=krbldap.edt.org,dc=
 edt,dc=org

dn: krbPrincipalName=kadmin/history@EDT.ORG,cn=EDT.ORG,cn=krbldap.edt.org,dc=e
 dt,dc=org
 ```
 
Create the stashfile for the database administrator.

 ```bash
[root@krbldap docker]# mkdir /etc/krb5kdc/
[root@krbldap docker]# kdb5_ldap_util -D cn=admin,dc=edt,dc=org stashsrvpw -f /etc/krb5kdc/admin.stash cn=admin,dc=edt,dc=org
Password for "cn=admin,dc=edt,dc=org": kadmin
Password for "cn=admin,dc=edt,dc=org": kadmin
Re-enter password for "cn=admin,dc=edt,dc=org": kadmin

 ```

Start the services and verify if the services are running.
 ```bash
[root@krbldap docker]# /usr/sbin/krb5kdc
[root@krbldap docker]# /usr/sbin/kadmind 
[root@krbldap docker]# ps ax
  PID TTY      STAT   TIME COMMAND
    1 ?        Ss     0:00 /bin/bash /opt/docker/startupldap.sh
    8 ?        Sl     0:00 /usr/sbin/slapd -d0 -u ldap -h ldap:/// ldaps:/// ldapi:///
   10 ?        Ss     0:00 /bin/bash
   70 ?        Ss     0:00 /usr/sbin/krb5kdc
   72 ?        Ss     0:00 /usr/sbin/kadmind
   73 ?        R+     0:00 ps ax
 ```

Verify the database.
 ```bash
[root@krbldap docker]# kadmin.local
Authenticating as principal root/admin@EDT.ORG with password.
kadmin.local:  listprincs 
K/M@EDT.ORG
krbtgt/EDT.ORG@EDT.ORG
kadmin/admin@EDT.ORG
kadmin/krbldap.edt.org@EDT.ORG
kiprop/krbldap.edt.org@EDT.ORG
kadmin/changepw@EDT.ORG
kadmin/history@EDT.ORG
 ```

It's possible to add principals. In this case add tania and tania/admin, the last one to prove the [acls](https://github.com/isx434324/kerberosproject/blob/master/backendLDAP/krbldap.edt.org/kadm5.acl) on the kerberos database.

 ```bash
 [root@krbldap docker]# kadmin.local   
Authenticating as principal root/admin@EDT.ORG with password.

kadmin.local:  addprinc tania
WARNING: no policy specified for tania@EDT.ORG; defaulting to no policy
Enter password for principal "tania@EDT.ORG": ktania
Re-enter password for principal "tania@EDT.ORG": ktania
Principal "tania@EDT.ORG" created.

kadmin.local:  addprinc tania/admin
WARNING: no policy specified for tania/admin@EDT.ORG; defaulting to no policy
Enter password for principal "tania/admin@EDT.ORG": ktania
Re-enter password for principal "tania/admin@EDT.ORG": ktania
Principal "tania/admin@EDT.ORG" created.
 ```

Looking at the LDAP database.

 ```bash
 
 [root@krbldap docker]# ldapsearch -x -LLL dn
dn: dc=edt,dc=org

dn: ou=usuaris,dc=edt,dc=org

dn: ou=maquines,dc=edt,dc=org

dn: ou=clients,dc=edt,dc=org

dn: ou=productes,dc=edt,dc=org

dn: ou=hosts,dc=edt,dc=org

dn: ou=networks,dc=edt,dc=org

dn: ou=groups,dc=edt,dc=org

dn: cn=Pau Pou,ou=usuaris,dc=edt,dc=org

dn: cn=Pere Pou,ou=usuaris,dc=edt,dc=org

dn: cn=Anna Pou,ou=usuaris,dc=edt,dc=org

dn: cn=Marta Mas,ou=usuaris,dc=edt,dc=org

dn: cn=Jordi Mas,ou=usuaris,dc=edt,dc=org

dn: cn=krbldap.edt.org,dc=edt,dc=org

dn: cn=EDT.ORG,cn=krbldap.edt.org,dc=edt,dc=org

dn: krbPrincipalName=K/M@EDT.ORG,cn=EDT.ORG,cn=krbldap.edt.org,dc=edt,dc=org

dn: krbPrincipalName=krbtgt/EDT.ORG@EDT.ORG,cn=EDT.ORG,cn=krbldap.edt.org,dc=e
 dt,dc=org

dn: krbPrincipalName=kadmin/admin@EDT.ORG,cn=EDT.ORG,cn=krbldap.edt.org,dc=edt
 ,dc=org

dn: krbPrincipalName=kadmin/krbldap.edt.org@EDT.ORG,cn=EDT.ORG,cn=krbldap.edt.
 org,dc=edt,dc=org

dn: krbPrincipalName=kiprop/krbldap.edt.org@EDT.ORG,cn=EDT.ORG,cn=krbldap.edt.
 org,dc=edt,dc=org

dn: krbPrincipalName=kadmin/changepw@EDT.ORG,cn=EDT.ORG,cn=krbldap.edt.org,dc=
 edt,dc=org

dn: krbPrincipalName=kadmin/history@EDT.ORG,cn=EDT.ORG,cn=krbldap.edt.org,dc=e
 dt,dc=org

dn: krbPrincipalName=taniaprova@EDT.ORG,cn=EDT.ORG,cn=krbldap.edt.org,dc=edt,d
 c=org

dn: krbPrincipalName=tania/admin@EDT.ORG,cn=EDT.ORG,cn=krbldap.edt.org,dc=edt,
 dc=org

dn: krbPrincipalName=tania@EDT.ORG,cn=EDT.ORG,cn=krbldap.edt.org,dc=edt,dc=org
 
 ```


Tania doesn't have list privileges in the acls.
 ```bash
 [root@krbldap docker]# kadmin -p tania 
Authenticating as principal tania with password.
Password for tania@EDT.ORG: 
kadmin:  listprincs
get_principals: Operation requires \`\`list'' privilege while retrieving list.
kadmin:  quit
 
 ```

Tania/admin as a principal can administrate perfectly.
 ```bash
 [root@krbldap docker]# kadmin -p tania/admin
Authenticating as principal tania/admin with password.
Password for tania/admin@EDT.ORG: ktania

kadmin:  listprincs
K/M@EDT.ORG
krbtgt/EDT.ORG@EDT.ORG
kadmin/admin@EDT.ORG
kadmin/krbldap.edt.org@EDT.ORG
kiprop/krbldap.edt.org@EDT.ORG
kadmin/changepw@EDT.ORG
kadmin/history@EDT.ORG
taniaprova@EDT.ORG
tania/admin@EDT.ORG
tania@EDT.ORG

kadmin:  change_password kadmin/admin
Enter password for principal "kadmin/admin@EDT.ORG": kadmin
Re-enter password for principal "kadmin/admin@EDT.ORG": kadmin
Password for "kadmin/admin@EDT.ORG" changed.

 ```
