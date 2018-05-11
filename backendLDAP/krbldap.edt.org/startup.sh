/usr/sbin/kadmind -x host=ldap://ldapserver -x binddn=cn=Manager,dc=edt,dc=org -P /var/run/kadmind.pid $KADMIND_ARGS
/usr/sbin/krb5kdc -P /var/run/krb5kdc.pid $KRB5KDC_ARGS
