#Ldapserver detached amb tls

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




