dnf -y install nmap iputils  iproute procps krb5-server krb5-libs krb5-workstation krb5-server-ldap openldap-clients
cp ldap.conf /etc/openldap/
cp kdc.conf kadm5.acl /var/kerberos/krb5kdc/
cp krb5.conf /etc/
cp cacert.pem /etc/openldap/certs/

