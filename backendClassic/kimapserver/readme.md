# Model 4 - IMAP Kerberized

## Features

Having the [Kerberos](https://github.com/isx434324/kerberosproject/tree/master/backendClassic/krb.edt.org) server running in background and [kclient](https://github.com/isx434324/kerberosproject/tree/master/backendClassic/kclient) interactive we will perform an IMAP Server using kerberos authentication.

## Instalation
### Hostname and ip

- IMAP Server: kimapserver 172.11.0.6


#### Create image

 ```bash
 # docker build -t kimapserver .
 ```
 
#### Run container
 ```bash
 # docker run --name kimapserver --hostname imappserver --net kerberos --privileged --ip 172.11.0.6  -d kimapserver
 ```

As the container is not interactive, you can acces:

    docker exec -it kftpserver /bin/bash


#### Procedure

Enable IMAP service in xinetd directory.
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

Active the use of PAM module in the service authentication.
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

Add user without unix password. (Must exist in kerberos database)

 ```bash
[root@kimapserver docker]# useradd tania
 ```

Check the port for the IMAP service is active.
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

As client, login with kerberos password.

 ```bash
[root@kclient docker]# telnet kimapserver 143
Trying 172.11.0.6...
Connected to kimapserver.
Escape character is '^]'.
* OK [CAPABILITY IMAP4REV1 I18NLEVEL=1 LITERAL+ SASL-IR LOGIN-REFERRALS STARTTLS] imappserver IMAP4rev1 2007f.404 at Mon, 21 May 2018 02:15:50 +0000 (UTC)
a login tania ktania
a OK [CAPABILITY IMAP4REV1 I18NLEVEL=1 LITERAL+ IDLE UIDPLUS NAMESPACE CHILDREN MAILBOX-REFERRALS BINARY UNSELECT ESEARCH WITHIN SCAN SORT THREAD=REFERENCES THREAD=ORDEREDSUBJECT MULTIAPPEND] User tania authenticated
a logout
* BYE imappserver IMAP4rev1 server terminating connection
a OK LOGOUT completed
Connection closed by foreign host.

 ```
