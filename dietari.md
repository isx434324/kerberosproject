#Dietari

**Lunes 23/04/2018**

estudie para examen de sistemas

**Martes 24/04/2018**

examen de sistemas

**Miercoles 25/04/2018**

leer y ordenar un poco documentacion y ordres

**Jueves 26/04/2018**

Montar servidor amb backend clasic I estudiar eines de backup (krb5 dump)
comenzar amb el de ldap, falla

kdb5_util dump -verbose dumpfile
kdb5_util dump -verbose dumpfile pak/admin@ENG.EXAMPLE.COM pak@ENG.EXAMPLE.COM

apagar serveis
kdb5_util load -update -d database1 dumpfil
engegar serveis

**Viernes 27/04/2018 **

montar servidor amb backend ldap, crear els dns de kdc I kadmin, posar acls, falla al crear base de dades en server kerberos

[root@pkserver /]# kdb5_ldap_util -D cn=Manager,dc=edt,dc=org create -r EDT.ORG -s
Password for "cn=Manager,dc=edt,dc=org": 
Initializing database for realm 'EDT.ORG'
You will be prompted for the database Master Password.
It is important that you NOT FORGET this password.
Enter KDC database master key: 
Re-enter KDC database master key to verify: 
kdb5_ldap_util: Kerberos Container create FAILED: Invalid syntax while creating realm 'EDT.ORG'

**Sabado 28/04/2018**

Ya no falla al crear el realm pero ara falla en iniciar el servei

[root@pkserver /]# kdb5_ldap_util -D cn=Manager,dc=edt,dc=org create -r EDT.ORG -s
Password for "cn=Manager,dc=edt,dc=org": 
Initializing database for realm 'EDT.ORG'
You will be prompted for the database Master Password.
It is important that you NOT FORGET this password.
Enter KDC database master key: 
Re-enter KDC database master key to verify: 

[root@pkserver /]# ./startup.sh 
krb5kdc: cannot initialize realm EDT.ORG - see log file for details
kadmind: kadmind: LDAP bind dn value missing while initializing, aborting

**Miercoles 02/05/2018**

Ara enciende el krb5 pero no el kdc, sigue sin hacer el bind al cn del kadmin
[root@pkserverc docker]# ./startup.sh 
kadmind: kadmind: LDAP bind dn value missing while initializing, aborting
krb5 ON


[root@pkserverc docker]# cat /var/log/k*.log
May 02 08:17:30 pkserverc kadmind\[323](Error): LDAP bind dn value missing while initializing, aborting

otp: Loaded
May 02 08:17:30 pkserverc krb5kdc\[324](info): setting up network...
May 02 08:17:30 pkserverc krb5kdc\[324](info): listening on fd 8: udp 0.0.0.0.88 (pktinfo)
krb5kdc: setsockopt(9,IPV6_V6ONLY,1) worked
May 02 08:17:30 pkserverc krb5kdc\[324](info): listening on fd 9: udp ::.88 (pktinfo)
krb5kdc: setsockopt(10,IPV6_V6ONLY,1) worked
krb5kdc: Address already in use - Cannot bind server socket on ::.88
May 02 08:17:30 pkserverc krb5kdc\[324](info): set up 2 sockets
May 02 08:17:30 pkserverc krb5kdc\[325](info): commencing operation

**Jueves 03/05/2018**







