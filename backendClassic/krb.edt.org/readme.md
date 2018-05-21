# Model 1 - Basic treatment of the kerberos database

## Overview

In this model, we will perform a Server Kerberos with a classic backend.
I put exemples of the principals orders for the basic management of a kerberos db2 database from the beginning.
For this we will use a kerberos server _krb.edt.org_.

## Features

Manipulation and treatment of the kerberos database

- Kadmin/kadmin.local
- Date Format
- Principals
- Policies
- Global operations on the kerberos databse


## Instalation
### Hostname and ip

- Kerberos Server: krb.edt.org 172.11.0.2

#### Create image

 ```bash
 # docker build -t krb.edt.org .
 ```
 
#### Run container
 ```bash
 # docker run --name krb.edt.org --hostname krb.edt.org --net kerberos --privileged --ip 172.11.0.2  -d krb.edt.org
 ```

As the container is not interactive, you can acces:

    docker exec -it krb.edt.org /bin/bash


Having the container running we can start to prove how to administrate our database.

### Kadmin/kadmin.local

Add principal using defaults parameters.
 ```bash
[root@krb docker]# kadmin.local -q "add_principal tania"
Authenticating as principal root/admin@EDT.ORG with password.
WARNING: no policy specified for tania@EDT.ORG; defaulting to no policy
Enter password for principal "tania@EDT.ORG": ktania
Re-enter password for principal "tania@EDT.ORG":  ktania
Principal "tania@EDT.ORG" created.
 ```

Add principal to have permissions on kerberos databse.
 
 ```bash
 [root@krb docker]# kadmin.local  -q "addprinc tania/admin"
Authenticating as principal root/admin@EDT.ORG with password.
WARNING: no policy specified for tania/admin@EDT.ORG; defaulting to no policy
Enter password for principal "tania/admin@EDT.ORG": ktania
Re-enter password for principal "tania/admin@EDT.ORG": ktania
Principal "tania/admin@EDT.ORG" created. 
 ```

Add the principal specifying the identity (user with permissions) and realm.
 ```bash 
[root@krb docker]# kadmin -p tania/admin -r EDT.ORG -q "addprinc pere"
Authenticating as principal tania/admin with password.
Password for tania/admin@EDT.ORG: 
WARNING: no policy specified for pere@EDT.ORG; defaulting to no policy
Enter password for principal "pere@EDT.ORG": 
Re-enter password for principal "pere@EDT.ORG": 
Principal "pere@EDT.ORG" created.
 ```

List principals on kerberos database.
 ```bash
[root@krb docker]# kadmin.local -q "list_principals"
Authenticating as principal root/admin@EDT.ORG with password.
K/M@EDT.ORG
kadmin/admin@EDT.ORG
kadmin/changepw@EDT.ORG
kadmin/pkserver@EDT.ORG
kiprop/pkserver@EDT.ORG
krbtgt/EDT.ORG@EDT.ORG
pere@EDT.ORG
tania@EDT.ORG
tania/admin@EDT.ORG
 ```

### Date Format


**Months:** january, jan, february, feb, march, mar, april, apr, may, june, jun, july, jul,
august, aug, september, sep, sept, october, oct, november, nov, december, dec

**Days:** sunday, sun, monday, mon, tuesday, tues, tue, wednesday, wednes, wed, thurs-
day, thurs, thur, thu, friday, fri, saturday, sat

**Units:** year, month, fortnight, week, day, hour, minute, min, second, sec

**Relative:** tomorrow, yesterday, today, now, last, this, next, first, second, third, fourth,
fifth, sixth, seventh, eighth, ninth, tenth, eleventh, twelfth, ago

**Time Zones:** kadmin recognizes abbreviations for most of the world’s time zones.

### Principals

List principals on kerberos database.
 ```bash
[root@krb docker]# kadmin.local
Authenticating as principal root/admin@EDT.ORG with password.

kadmin.local: get_principals
K/M@EDT.ORG
kadmin/admin@EDT.ORG
kadmin/changepw@EDT.ORG
kadmin/pkserver@EDT.ORG
kiprop/pkserver@EDT.ORG
krbtgt/EDT.ORG@EDT.ORG
tania@EDT.ORG
 ```

Get information of a principal.
 ```bash
kadmin.local:  get_principal tania
Principal: tania@EDT.ORG
Expiration date: [never]
Last password change: Thu May 03 11:21:14 UTC 2018
Password expiration date: [none]
Maximum ticket life: 1 day 00:00:00
Maximum renewable life: 0 days 00:00:00
Last modified: Thu May 03 11:21:14 UTC 2018 (root/admin@EDT.ORG)
Last successful authentication: [never]
Last failed authentication: [never]
Failed password attempts: 0
Number of keys: 8
Key: vno 2, aes256-cts-hmac-sha1-96
Key: vno 2, aes128-cts-hmac-sha1-96
Key: vno 2, des3-cbc-sha1
Key: vno 2, arcfour-hmac
Key: vno 2, camellia256-cts-cmac
Key: vno 2, camellia128-cts-cmac
Key: vno 2, des-hmac-sha1
Key: vno 2, des-cbc-md5
MKey: vno 1
Attributes:
Policy: [none]
 ```

Change password of a principal.
 ```bash
kadmin.local:  change_password tania
Enter password for principal "tania@EDT.ORG": 
Re-enter password for principal "tania@EDT.ORG": 
Password for "tania@EDT.ORG" changed.
 ```

Modify the expiration date of the password.
 ```bash
kadmin.local:  modify_principal -pwexpire 05/10/2019 tania
Principal "tania@EDT.ORG" modified.

kadmin.local:  get_principal tania
Principal: tania@EDT.ORG
Expiration date: [never]
Last password change: Thu May 03 11:21:14 UTC 2018
Password expiration date: **Fri May 10 00:00:00 UTC 2019**
Maximum ticket life: 1 day 00:00:00
Maximum renewable life: 0 days 00:00:00
Last modified: Thu May 03 11:29:17 UTC 2018 (root/admin@EDT.ORG)
Last successful authentication: [never]
Last failed authentication: [never]
Failed password attempts: 0
Number of keys: 8
Key: vno 2, aes256-cts-hmac-sha1-96
Key: vno 2, aes128-cts-hmac-sha1-96
Key: vno 2, des3-cbc-sha1
Key: vno 2, arcfour-hmac
Key: vno 2, camellia256-cts-cmac
Key: vno 2, camellia128-cts-cmac
Key: vno 2, des-hmac-sha1
Key: vno 2, des-cbc-md5
MKey: vno 1
Attributes:
Policy: [none]
 ```

Rename a principal.
 ```bash
kadmin.local:  rename_principal tania taniaguapa
Are you sure you want to rename the principal "tania@EDT.ORG" to "taniaguapa@EDT.ORG"? (yes/no): yes
Principal "tania@EDT.ORG" renamed to "taniaguapa@EDT.ORG".
Make sure that you have removed the old principal from all ACLs before reusing.
kadmin.local:  list_principals
K/M@EDT.ORG
kadmin/admin@EDT.ORG
kadmin/changepw@EDT.ORG
kadmin/pkserver@EDT.ORG
kiprop/pkserver@EDT.ORG
krbtgt/EDT.ORG@EDT.ORG
taniaguapa@EDT.ORG
 ```

Delete a principal.
 ```bash
kadmin.local: delete_principal taniaguapa
Are you sure you want to delete the principal "taniaguapa@EDT.ORG"? (yes/no): yes
Principal "taniaguapa@EDT.ORG" deleted.
Make sure that you have removed this principal from all ACLs before reusing.
kadmin.local:  list_principals
K/M@EDT.ORG
kadmin/admin@EDT.ORG
kadmin/changepw@EDT.ORG
kadmin/pkserver@EDT.ORG
kiprop/pkserver@EDT.ORG
krbtgt/EDT.ORG@EDT.ORG
 ```

### Policies

Add a new policy with:
- 6 minimum characters when creating the password.
- 5 maximum failed intents of authentication.
- 5 minutes to restart the count of failures in the condition mentioned above.
- 1 hour of account locking if a condition in the polcicy has arrived at the limit.

 ```bash
kadmin.local:  add_policy -minlength 6 -maxfailure 5 -failurecountinterval "5 minutes" -lockoutduration "1 hour" policy_segura
 ```

List the existent policies.
 ```bash
kadmin.local:  get_policies
policy_segura
 ```

Get the information of a policy.
 ```bash
kadmin.local:  get_policy policy_segura
Policy: policy_segura
Maximum password life: 0
Minimum password life: 0
Minimum password length: 6
Minimum number of password character classes: 1
Number of old keys kept: 1
Maximum password failures before lockout: 5
Password failure count reset interval: 0 days 00:05:00
Password lockout duration: 0 days 01:00:00
 ```

Modify a condition in the policy.
 ```bash
kadmin.local:  modify_policy -lockoutduration "2 hours" policy_segura
kadmin.local:  get_policy policy_segura
Policy: policy_segura
Maximum password life: 0
Minimum password life: 0
Minimum password length: 6
Minimum number of password character classes: 1
Number of old keys kept: 1
Maximum password failures before lockout: 5
Password failure count reset interval: 0 days 00:05:00
Password lockout duration: 0 days 02:00:00
 ```

Delete a policy.
 ```bash
kadmin.local:  get_policies
policy_segura

kadmin.local:  delete_policy policy_segura
Are you sure you want to delete the policy "policy_segura"? (yes/no): yes

kadmin.local:  get_policies
kadmin.local:
 ```
 
### Global operations on the kerberos database

Delete a database.
 ```bash
[root@pkserver docker]# kdb5_util -r EDT.ORG destroy
Deleting KDC database stored in '/var/kerberos/krb5kdc/principal', are you sure?
(type 'yes' to confirm)? yes
OK, deleting database '/var/kerberos/krb5kdc/principal'...
** Database '/var/kerberos/krb5kdc/principal' destroyed.
 ```

Create a database.
 ```bash
[root@pkserver docker]# kdb5_util create -r TANIA.ORG -s
Loading random data
Initializing database '/var/kerberos/krb5kdc/principal' for realm 'TANIA.ORG',
master key name 'K/M@TANIA.ORG'
You will be prompted for the database Master Password.
It is important that you NOT FORGET this password.
Enter KDC database master key: masterkey
Re-enter KDC database master key to verify: masterkey
 ```

Make a stash file for the authentication of the kdc when doing kadmin and database utilities.

 ```bash
[root@pkserver docker]# kdb5_util stash -f stashfile
Using existing stashed keys to update stash file.
 ```

 ```bash
[root@pkserver docker]# cat stashfile
#B#EDT.ORG#K#M#Z�#�## _�2פ��#&�8��|o��#����H��h|.�*�#
 ```
