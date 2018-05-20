# Model 4 - IMAP Kerberized

## Features

In this model, we will perform an IMAP server using kerberos authentication.

## Instalation
### Hostnames and ips

- Kerberos Server: krb.edt.org 172.11.0.2
- IMAP Server: kimapserver 172.11.0.6

RECORDA FER LA PROVA DESDE EL CLIENT


#### Create image
_Being in the directori [kimapserver](https://github.com/isx434324/kerberosproject/backendClassic/kimapserver)_

 ```bash
 # docker build -t kimapserver .
 ```
 
#### Run container for kerberos server
 ```bash
 # docker run --name kimapserver --hostname imappserver --net kerberos --privileged --ip 172.11.0.6  -d kimapserver
 ```

Active IMAP service in xinetd directory.

  ```bash

[root@kimapserver docker]# vim /etc/xinetd.d/imap
# default: off
# description: The IMAP service allows remote users to access their mail using \
#              an IMAP client such as Mutt, Pine, fetchmail, or Netscape \
#              Communicator.
service imap
{
	socket_type		= stream
	wait			= no
	user			= root
	server			= /usr/sbin/imapd
	log_on_success	+= HOST DURATION
	log_on_failure	+= HOST
	disable			= no
}

 ```

Active the use of PAM module in the service authentication .
 ```bash
[root@kimapserver docker]# vim /etc/pam.d/imap
#%PAM-1.0
#auth       required     pam_nologin.so
auth       sufficient   pam_krb5.so
#auth       include      password-auth

account    include      password-auth
account    sufficient   pam_krb5.so

session    include      password-auth
session    sufficient   pam_krb5.so
 ```
 
Run the service.

 ```bash
[root@kimapserver docker]# cat startup.sh
#!/bin/bash
/usr/sbin/xinetd

[root@kimapserver docker]# ./startup.sh
 ```


Prove that the port for the IMAP service is active.
 ```bash
[root@kimapserver docker]# nmap localhost 

Starting Nmap 7.40 ( https://nmap.org ) at 2018-05-16 09:45 UTC
Nmap scan report for localhost (127.0.0.1)
Host is up (0.0000050s latency).
Other addresses for localhost (not scanned): ::1
Not shown: 999 closed ports
PORT    STATE SERVICE
143/tcp open  imap

Nmap done: 1 IP address (1 host up) scanned in 0.10 seconds
 ```

Login as pere with the kerberos password (kpere).
 ```bash
[root@kimapserver docker]# telnet localhost 143
Trying ::1...
Connected to localhost.
Escape character is '^]'.
* OK [CAPABILITY IMAP4REV1 I18NLEVEL=1 LITERAL+ SASL-IR LOGIN-REFERRALS STARTTLS] localhost IMAP4rev1 2007f.404 at Wed, 16 May 2018 09:47:02 +0000 (UTC)

a login pere kpere
a OK [CAPABILITY IMAP4REV1 I18NLEVEL=1 LITERAL+ IDLE UIDPLUS NAMESPACE CHILDREN MAILBOX-REFERRALS BINARY UNSELECT ESEARCH WITHIN SCAN SORT THREAD=REFERENCES THREAD=ORDEREDSUBJECT MULTIAPPEND]

User pere authenticated

a logout
* BYE kimapserver IMAP4 rev1 server terminating connection
a OK LOGOUT completed
Connection closed by foreign host.
 ```
