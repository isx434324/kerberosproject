export TERM=xterm-color
/usr/sbin/slapd -u ldap -h "ldap:/// ldaps:/// ldapi:///"
/usr/sbin/krb5kdc -P /var/run/krb5kdc.pid $KRB5KDC_ARGS
/usr/sbin/kadmind -nofork -x binddn=cn=admin,dc=edt,dc=org -P /var/run/kadmind.pid $KADMIND_ARGS
