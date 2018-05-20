# Kerberos Service

Tania Gabriela Bonilla Alvarenga

Isx434324

Network Informatic Systems Administration  - HISX2 2017-2018

### Objective
The present project consist in different implementation of Kerberos service in _Docker Containers_.

We are going to walk through the backend types of the Kerberos database (Classic and LDAP) and see how it basically works:

- Model of the Kerberos authentication process (Unix, SSH , PAM, LDAP, Kerberos).
- Manipulation and treatment of kerberos database.
	-Policies de Passwords
	-Privileges
	-Account Lockout
- Imports, exports and backups of kerberos database. 
- Addition and update of principals (basic treatment) and services (keytab files).


### Introduccion
In an environment that provides network services, you use client programs to request services
from server programs that are somewhere on the network.

####Kerberos Tickets

In Kerberos, the service daemon allows you to login to a remote machine if you can
provide the daemon a Kerberos ticket which proves your identity. In addition to the ticket,
you must also have possession of the corresponding ticket session key.

The combination ofa ticket and the ticket’s session key is known as a **_credential_**.

Typically, a client program automatically obtains credentials identifying the person using
the client program.

The credentials are obtained from a Kerberos server that resides some-
where on the network. A Kerberos server maintains a database of user, server, and password
information.

#### The Kerberos Database

Kerberos will give you credentials only if you have an entry in the Kerberos server’s Kerberos
database. This database entry includes a Kerberos principal(often username) and your Kerberos password.

Every Kerberos user must have an entry in this database.

#### Kerberos Realms

Each administrative domain will have its own Kerberos database or **_Realm_**, which contains informa-
tion about the users and services for that particular site or administrative domain.

#### The Ticket-Granting Ticket

The ‘kinit’ command prompts for your password. If you enter it successfully, you will
obtain your **_credentials_** (ticket-granting ticket and ticket session key) which gives you the right to use the ticket.

#### Network Services and the Master Database

The master database also contains entries for all network services that require Kerberos authentication.

This service must be registered in the Kerberos database, using the proper service name,
which in this case is the principal:
	
	host/laughter.mit.edu@ATHENA.MIT.EDU


The ‘/’ character separates the Kerberos _primary_ from the _instance_; the ‘@’ character separates the _realm_ name from the rest of the principal.

The primary, ‘host’, denotes the name or type of the service that is being offered: generic host-level access to the machine.
The instance, ‘laughter.mit.edu’, names the specific machine that is offering this service.


#### The Keytab File

For each service, there must be a _service key_ known only by Kerberos and the service.

On the Kerberos server, the service key is stored in the Kerberos database.
On the server host, these service keys are stored in key tables, which are files known as
keytabs.


#### The User/Kerberos Interaction

1. You login to the workstation and use the ‘kinit’ command to get a ticket-granting
ticket. This command prompts you for your Kerberos password.

	A. The ‘kinit’ command sends your request to the Kerberos master server machine.
	The server software looks for your principal name’s entry in the Kerberos database.
	
	B. If this entry exists, the Kerberos server creates and returns a ticket-granting ticket
	and the key which allows you to use it, encrypted by your password.
	
	If ‘kinit’ can decrypt the Kerberos reply using the password you provide, it stores this ticket in
	a credentials cache on your local machine for later use.
	
2. Now you use the service client to access the server offering the service.

	A. The service client checks your ticket file to see if you have a ticket for the ‘host’
	service. You don’t, so it uses the credential cache’s _ticket-granting ticket_
	to make a request to the master server’s _ticket-granting service_.

	B. This ticket-granting service receives the request for a ticket and looks in the master database.
	If the entry exists, the ticket-granting service issues you a ticket for that service.
	That ticket is also cached in your credentials cache.

	C. The client now sends that ticket to the service program.
	The service program checks the ticket by using its own service key.
	If the ticket is valid, the service daemon will let you user its service.


