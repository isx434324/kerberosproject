#Ldapserver detached amb tls

Per consultar funcionament com client

 ```bash
ldapsearch -x -LLL -H ldaps://ldapserver -s base
ldapsearch -x -LLL -ZZ -H ldap://ldapserver -s base
 ```

